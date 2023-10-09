import 'dart:io';
import 'dart:math';
import 'package:dorandoran/common/css.dart';
import 'package:dorandoran/common/model/notification_model.dart';
import 'package:dorandoran/texting/home/quest/get_feed_notification.dart';
import 'package:dorandoran/texting/home/quest/get_home_notification.dart';
import 'package:dorandoran/texting/home/quest/home_getcontent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:solar_icons/solar_icons.dart';
import '../../common/uri.dart';
import '../../hash/home_hash/tag_screen.dart';
import '../../write/screen/write.dart';
import 'component/home_message_card.dart';
import 'component/home_top.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

DateTime? currentBackPressTime;

class _HomeState extends State<Home> {
  RefreshController _refreshController = RefreshController(initialRefresh: true);
  ScrollController scrollController = ScrollController();
  late Future myfuture;
  List<Widget> item=[];
  int checknumber=0;
  String url='?';
  String tagtitle = "새로운";
  int addcount=0;
  int distance=1;
  Map<String, bool> buttonColor={"새로운":true,"근처에":false,"인기있는":false,"관심있는":false};
  //광고
  NativeAd? _nativeAd;
  bool _nativeAdIsLoaded = false;
  final String _adUnitId = Platform.isIOS ? 'ca-app-pub-2389438989674944/3518867863' : 'ca-app-pub-2389438989674944/5510606382';
  int number =Random().nextInt(100)+1;
  NotificationModel? homenotice;
  NotificationModel? feednotice;
  Widget? homenoticewidget;
  Widget? feednoticewidget;
  bool feedpopup=false;
  @override
  void initState() {
    super.initState();
    //_loadAd();
    getnoticiations();
    myfuture = getPostContent(url, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(
            onWillPop: onWillPop,
            child: Container(
                color: backgroundcolor,
                child: SafeArea(
                    top: true,
                    bottom: true,
                    child: FutureBuilder(
                        future: myfuture,
                        builder: (context, snapshot) {
                          if(snapshot.hasData){
                            SchedulerBinding.instance!.addPostFrameCallback((_) {//위젯을 바로실행시키기 위해 이 함수가 필요하다.
                              if(feednotice!=null && tagtitle=="새로운"&&feedpopup==false) {
                                feedpopup=true;
                                feednoticepopup();
                              }
                            });
                            int lastnumber = snapshot.data.length > 0 ? snapshot.data!.last.postId : 0;
                            if (snapshot.connectionState == ConnectionState.done) {
                              if ((item.length == 0 || item == null) && snapshot.data!.length > 0) {
                                item = [];
                              }
                              else{
                                if (item.length/20>addcount && _nativeAdIsLoaded && _nativeAd != null) {
                                  // item!.add(SizedBox(
                                  //     height: 100.h,
                                  //     width: MediaQuery
                                  //         .of(context)
                                  //         .size
                                  //         .width,
                                  //     child: AdWidget(ad: _nativeAd!)));
                                }
                              }
                              if (checknumber != lastnumber) {
                                item.addAll(snapshot.data!
                                    .map<Widget>((e) => Message_Card(
                                  time: e.postTime,
                                  heart: e.likeCnt,
                                  chat: e.replyCnt,
                                  map: e.location,
                                  message: e.contents,
                                  backimg: e.backgroundPicUri,
                                  postId: e.postId,
                                  font: e.font,
                                  fontColor: e.fontColor,
                                  fontSize: e.fontSize,
                                  fontBold: e.fontBold,
                                )).toList());
                                checknumber=snapshot.data.length>0 ? snapshot.data[snapshot.data!.length-1].postId:0;
                              }
                            }
                            //홈팝업 구현하기
                            if(homenotice!=null){
                              homenoticewidget= Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                                  child: Container(
                                      height: 60.h,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage('$urls/api/pic/default/' + number.toString()),
                                          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child:Center(child:Text(homenotice?.content ??"공지사항" ,style: TextStyle(color: Colors.white, fontSize: 22.sp, fontWeight: FontWeight.w600),))
                                  ));
                            }
                            Widget tagname(String name) {
                              IconData icons = Icons.add;
                              if (name == "근처에")
                                icons = SolarIconsBold.peopleNearby;
                              else if (name == "인기있는")
                                icons = SolarIconsBold.fire;
                              else if (name == "새로운")
                                icons = SolarIconsBold.home;
                              else if (name == "관심있는")
                                icons = SolarIconsBold.starFall;
                              return IconButton(
                                onPressed: () {
                                  postlistchange(name);
                                  checknumber=0;
                                  setState(() {
                                    buttonColor.forEach((key, value) {
                                      buttonColor[key]=false;
                                    });
                                    buttonColor[name]=true;
                                    item.clear();
                                    myfuture = getPostContent(url, 0);
                                  //_loadAd();
                                  });
                                  _refreshController.refreshCompleted();
                                },
                                icon:Icon(icons,size: 30.r, color: buttonColor[name]==true ?Color(0xFF1C274C): Color(0x771C274C)),
                                padding: EdgeInsets.zero,
                              );
                            }
                            Widget kmname(int name) {
                              return TextButton(
                                onPressed: (){
                                  changekm(name);
                                  _refreshController.position!.animateTo(0.0,
                                    duration: const Duration(milliseconds: 100),
                                    curve: Curves.linear,
                                  );
                                  setState(() {
                                    checknumber=0;
                                    item.clear();
                                    myfuture =getPostContent(url, 0);
                                  });
                                  _refreshController.refreshCompleted();
                                },
                                child:Text('$name km',style: TextStyle(color:distance==name? Colors.blue:Colors.black)),
                              );
                            }
                            return Container(
                              decoration: gradient,
                              child: SafeArea(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 1),
                                  child: Stack(children: [
                                    Column(
                                      children: [
                                        Top(),
                                 //홈화면 공지
                                        (tagtitle!="관심있는"&&homenoticewidget!=null) ? homenoticewidget! :Container(),
                                        tagtitle=="근처에"? Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            kmname(1),
                                            kmname(5),
                                            kmname(10),
                                            kmname(20),
                                            kmname(30),
                                          ]
                                        ):Container(),
                                        Expanded(
                                            child: SmartRefresher(
                                          enablePullDown: true,
                                          enablePullUp: true,
                                          header: CustomHeader(
                                            builder: (BuildContext context, RefreshStatus? mode) {
                                              Widget body;
                                              if (mode == RefreshStatus.refreshing)
                                                body = CupertinoActivityIndicator();
                                              else
                                                body = Text('');

                                              return Container(
                                                height: 55.0,
                                                child: Center(child: body),
                                              );
                                            },
                                          ),
                                          footer: CustomFooter(
                                            builder: (BuildContext context, LoadStatus? mode) {
                                              Widget body;
                                              if (mode == RefreshStatus.refreshing)
                                                body = CupertinoActivityIndicator();
                                              else
                                                body = Text('');

                                              return Container(
                                                height: 55.0,
                                                child: Center(child: body),
                                              );

                                            },
                                          ),
                                          onRefresh: () async {
                                            setState(() {
                                              checknumber=0;
                                              item.clear();
                                              myfuture = getPostContent(url, 0);
                                            });
                                            _refreshController.refreshCompleted();
                                          },
                                          onLoading: () async {
                                            if (lastnumber - 1 > 0) {
                                              setState(() {
                                                myfuture = getPostContent(
                                                    url, lastnumber - 1);
                                                //_loadAd();
                                                checknumber = lastnumber;
                                              });
                                            }
                                            _refreshController.loadComplete();
                                          },
                                          controller: _refreshController,
                                          child: tagtitle == "관심있는"
                                              ? TagScreen()
                                              : (item.length==0 &&snapshot.data.length==0
                                                  ? Center(child: Text("조회된 게시글이 없습니다.", style: TextStyle(fontSize: 20.sp)))
                                                  : ListView(
                                                      controller: scrollController,
                                                      children: item.map<Widget>((e) => e).toList(),
                                                    )),
                                        ))
                                      ],
                                    ),
                                    Container(
                                        alignment: Alignment.bottomRight,
                                        child: Container(
                                            height: 50.h,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(10),
                                                    topRight: Radius.circular(10))),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 15),
                                              child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    tagname("새로운"),
                                                    tagname("근처에"),
                                                    IconButton(
                                                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Write())),
                                                      padding: EdgeInsets.zero,
                                                      icon: Icon(SolarIconsBold.penNewSquare,
                                                        size: 30.r,
                                                        color: Color(0xFF1C274C),
                                                      ),
                                                    ),
                                                    tagname("인기있는"),
                                                    tagname("관심있는"),
                                                  ]),
                                            ))),
                                  ]),
                                ),
                              ),
                            );
                          }
                          else {
                            return Container(
                                decoration: gradient,
                                child: SafeArea(
                                child: Padding(
                                padding: const EdgeInsets.only(bottom: 1),
                          child: Stack(children: [
                          Column(
                          children: [
                          Top(),
                          Flexible(
                              child:  Container(
                                decoration: gradient,
                                child: Center(child: CircularProgressIndicator()))),

                          ]
                          )
                          ])
                            )));
                          }
                        })))));
  }

  void _loadAd() {
    setState(() {
      _nativeAdIsLoaded=false;
    });
    _nativeAd = NativeAd(
        adUnitId: _adUnitId,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            setState(() {
              _nativeAdIsLoaded = true;
            });
          },
          onAdFailedToLoad: (ad, error) {
            // Dispose the ad here to free resources.
            print('$NativeAd failedToLoad: $error');
            ad.dispose();
          },
        ),
        request: const AdRequest(),
        //   factoryId: "listTile"
        // )
        nativeTemplateStyle:
            NativeTemplateStyle(templateType: TemplateType.small
                // templateType: TemplateType.small,
                //   mainBackgroundColor: Colors.white,
                //   cornerRadius: 10.0,
                //   callToActionTextStyle: NativeTemplateTextStyle(
                //       textColor: Colors.cyan,
                //       backgroundColor: Colors.red,
                //       style: NativeTemplateFontStyle.monospace,
                //       size: 10.0),
                //   primaryTextStyle: NativeTemplateTextStyle(
                //       textColor: Colors.red,
                //       backgroundColor: Colors.cyan,
                //       style: NativeTemplateFontStyle.italic,
                //       size: 16.0),
                //   secondaryTextStyle: NativeTemplateTextStyle(
                //       textColor: Colors.green,
                //       backgroundColor: Colors.black,
                //       style: NativeTemplateFontStyle.bold,
                //       size: 10.0),
                //   tertiaryTextStyle: NativeTemplateTextStyle(
                //       textColor: Colors.brown,
                //       backgroundColor: Colors.amber,
                //       style: NativeTemplateFontStyle.monospace,
                //       size: 10.0)
                ))
      ..load();
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      final msg = "'뒤로'버튼을 한 번 더 누르면 종료됩니다.";

      Fluttertoast.showToast(msg: msg);
      return Future.value(false);
    }

    return Future.value(true);
  }

  changekm(int name){
    setState(() {
      distance=name;
      url = '/close?range=$distance&';
    });
  }
  postlistchange(String name) {
    setState(() {
      switch (name) {
        case "근처에":
          tagtitle = "근처에";
          distance=1;
          url = '/close?range=$distance&';
          break;
        case "인기있는":
          tagtitle = "인기있는";
          url = '/popular?';
          break;
        case "새로운":
          tagtitle = "새로운";
          url = '?';
          break;
        case "관심있는":
          tagtitle = "관심있는";
          url = '?';
          break;
      }
    });
  }
  void feednoticepopup() async{
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
            return AlertDialog(
                backgroundColor: Colors.white,
                title: Text(feednotice!.title),
                content: Text(feednotice!.content,
                    style: Theme.of(context).textTheme.headlineMedium!),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("다시는 보지 않기", style: Theme.of(context).textTheme.labelSmall!,),
                     ),
                  TextButton(
                      onPressed: () {
                        //다시보지않음요청
                        Navigator.pop(context);
                      },
                      child: Text("확인", style: Theme.of(context).textTheme.labelSmall!,),
                      ),
                ]);
          });
  }

  getnoticiations() async {
    homenotice = await GetHomeNotification();
    feednotice = await GetFeedNOtification();
  }
}
