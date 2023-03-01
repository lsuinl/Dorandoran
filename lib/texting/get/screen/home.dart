import 'package:dorandoran/common/css.dart';
import 'package:dorandoran/common/storage.dart';
import 'package:dorandoran/texting/get/quest/like.dart';
import 'package:dorandoran/texting/get/quest/post.dart';
import 'package:dorandoran/texting/get/screen/maintext.dart';
import 'package:dorandoran/texting/write/screen/write.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dorandoran/common/util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  ScrollController scrollController = ScrollController();
  late Future myfuture;
  List<Message_Card>? item;
  int? checknumber;

  @override
  void initState() {
    super.initState();
    setState(() {
      _refreshController = RefreshController(initialRefresh: false);
      scrollController = ScrollController();
    });
    getlocation(); //임시
    myfuture = getPostContent(useremail, 0, latitude==''?'':'$latitude,$longtitude');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundcolor,
        body: FutureBuilder(
            future: myfuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                int lastnumber = snapshot.data!.last.postId;
                if (snapshot.connectionState == ConnectionState.done) {
                  if (item?.length == 0 || item == null) {
                    item = snapshot.data!
                        .map<Message_Card>((e) => Message_Card(
                              movetocard: movetocard,
                              time: e.postTime,
                              heart: e.likeCnt,
                              chat: e.replyCnt,
                              map: e.location,
                              message: e.contents,
                              backimg: e.backgroundPicUri,
                              postId: e.postId,
                      likeresult: e.likeResult,
                            ))
                        .toList();
                  } else {
                    if (checknumber != lastnumber) {
                      item!.addAll(snapshot.data!
                          .map<Message_Card>((e) => Message_Card(
                                movetocard: movetocard,
                                time: e.postTime,
                                heart: e.likeCnt,
                                chat: e.replyCnt,
                                map: e.location,
                                message: e.contents,
                                backimg: e.backgroundPicUri,
                                postId: e.postId,
                          likeresult: e.likeResult,
                              ))
                          .toList());
                    }
                  }
                }
                return Container(
                  decoration: gradient,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: SafeArea(
                        child: Stack(children: [
                          Column(
                            children: [
                              Top(),
                              SizedBox(height: 10.h),
                              Tag(),
                              Expanded(
                                child: SmartRefresher(
                                  enablePullDown: true,
                                  // 아래로 당겨서 새로고침
                                  enablePullUp: true,
                                  // 위로 당겨서 새로운 데이터
                                  //새로고침 로딩
                                  header: CustomHeader(
                                    builder: (BuildContext context,
                                        RefreshStatus? mode) {
                                      Widget body;
                                      if (mode == RefreshStatus.refreshing) {
                                        body = CupertinoActivityIndicator();
                                      } else {
                                        body = Text('');
                                      }
                                      return Container(
                                        height: 55.0,
                                        child: Center(child: body),
                                      );
                                    },
                                  ),
                                  // 바닥글
                                  footer: CustomFooter(
                                    builder:
                                        (BuildContext context, LoadStatus) {
                                      return Container(
                                        height: 55.0,
                                        child: Center(child: Text("")),
                                      );
                                    },
                                  ),
                                  onRefresh: () async {
                                    setState(() {
                                      item!.clear();
                                      myfuture = getPostContent(useremail, 0, latitude==null?'':'$latitude,$longtitude');
                                    });
                                    _refreshController.refreshCompleted();
                                  },
                                  // 새로고침
                                  onLoading: //무한 스크롤
                                      () async {
                                    if (lastnumber - 1 > 0) {
                                      setState(() {
                                        myfuture = getPostContent(
                                            useremail,
                                            lastnumber - 1,
                                            latitude==null?'':'$latitude,$longtitude');
                                        checknumber = lastnumber;
                                      });
                                      _refreshController.loadComplete();
                                    }
                                  },
                                  controller: _refreshController,
                                  child: ListView(
                                    controller: scrollController,
                                    children:
                                        item!.map<Widget>((e) => e).toList(),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Container(
                            alignment: Alignment.bottomRight,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                RawMaterialButton(
                                  onPressed: () async {
                                    _refreshController.position!.animateTo(
                                      0.0,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.linear,
                                    );
                                    setState(() {
                                      item!.clear();
                                      myfuture = getPostContent(useremail, 0,
                                          latitude==null?'':'$latitude,$longtitude');
                                    });
                                    print('새로고침');
                                    _refreshController.refreshCompleted();
                                  },
                                  elevation: 5.0,
                                  fillColor: Colors.white,
                                  child: Icon(
                                    Icons.restart_alt,
                                    size: 20.0.r,
                                  ),
                                  padding: EdgeInsets.all(15.0),
                                  shape: CircleBorder(),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                RawMaterialButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Write()));
                                  },
                                  elevation: 5.0,
                                  fillColor: Colors.white,
                                  child: Icon(
                                    Icons.edit,
                                    size: 50.0,
                                  ),
                                  padding: EdgeInsets.all(15.0),
                                  shape: CircleBorder(),
                                )
                              ],
                            ),
                          )
                        ]),
                      ),
                    ),
                  ),
                );
              } else {
                return Container(
                    decoration: gradient,
                    child: Center(child: CircularProgressIndicator()));
              }
            }));
  }

  void movetocard() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Main_Text()));
  }
}

//---------------------------------------------------
class Message_Card extends StatefulWidget {
  final VoidCallback movetocard;
  final String time;
  final int heart;
  final int? chat;
  final int? map;
  final String message;
  final String backimg;
  final int postId;
  final bool likeresult;

  const Message_Card(
      {required this.postId,
      required this.movetocard,
      required this.time,
      required this.heart,
      required this.chat,
      required this.map,
      required this.message,
      required this.backimg,
        required this.likeresult,
      Key? key})
      : super(key: key);

  @override
  State<Message_Card> createState() => _Message_CardState();
}

//bool like=false;
Map<int,bool> like={0:false};
Map<int,int> click={0:0};

class _Message_CardState extends State<Message_Card> {
  @override
  void initState(){
    //print("응애는초기화에요");
    setState(() {
    //  like=widget.likeresult;
      like.addAll({widget.postId : widget.likeresult});
      click.addAll({widget.postId :widget.heart});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      elevation: 2, //그림자
      child: InkWell(
        onTap: widget.movetocard,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              image: DecorationImage(
                image: NetworkImage('http://' + widget.backimg),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.7), BlendMode.dstATop),
              )),
          //BoxDecoration(image: DecorationImage(image:NetworkImage('http://'+backimg))),
          child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 150.h,
                    child: Container(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(widget.message,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 20.sp)),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.access_time_filled_rounded),
                          SizedBox(width: 3.w),
                          Text(timecount(widget.time)),
                          SizedBox(width: 7.w),
                          if (widget.map != null) Icon(Icons.place),
                          Text(widget.map == null ? '' : '${widget.map}km'),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                print(like);
                                like[widget.postId]= !like[widget.postId]!;
                                if(widget.likeresult==true && like[widget.postId]==false){//눌린상태에서 취소
                                  click[widget.postId]= click[widget.postId]!-1;
                                }
                                else if(widget.likeresult==false && like[widget.postId]==true){ //누르기
                                  click[widget.postId]= click[widget.postId]!+1;
                                }
                                else{ //해당화면에서 상태변경취소
                                  click[widget.postId]=widget.heart;
                                }
                              });
                              print('머게요${like}');
                              postLike(widget.postId, useremail!);
                            },
                            icon: like[widget.postId]!
                                ? Icon(Icons.favorite)
                                : Icon(Icons.favorite_border),
                            constraints: BoxConstraints(),
                            padding: EdgeInsets.zero,
                          ),
                              SizedBox(width: 3.w),
                          Text('${click[widget.postId]}'),
                          SizedBox(width: 7.w),
                          Icon(Icons.forum),
                          SizedBox(width: 3.w),
                          Text('${widget.chat}'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                ],
              )),
        ),
      ),
    );
  }
}

class Top extends StatefulWidget {
  const Top({Key? key}) : super(key: key);

  @override
  State<Top> createState() => _TopState();
}

bool suin = true;

class _TopState extends State<Top> {
  final List<String> _menulist = ['내 정보', '좋아요 한 글', '문의하기'];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              suin = !suin;
            });
          },
          icon: Icon(
            suin ? Icons.notifications : Icons.notifications_off,
            size: 30.0.r,
          ),
          padding: EdgeInsets.all(10.0),
        ),
        Text("도란도란", style: TextStyle(fontSize: 30.sp)),
        // RawMaterialButton(
        //   onPressed: () {},
        //   elevation: 0,
        //   fillColor: Colors.white,
        //   child: Icon(
        //     Icons.person,
        //     size: 30.0.r,
        //   ),
        //   padding: EdgeInsets.all(15.0),
        //   shape: CircleBorder(),
        // ),
        DropdownButton2(
          customButton: const Icon(
            Icons.person,
            size: 40,
          ),
          dropdownWidth: 150,
          dropdownDecoration: BoxDecoration(
              color: Colors.white
          ),
          dropdownDirection: DropdownDirection.left,
          items: [
            ..._menulist.map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              ),
            ),
          ],
          onChanged: (value) {},
        ),
      ],
    );
  }
}

class Tag extends StatelessWidget {
  const Tag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget tagname(String name) {
      return TextButton(
        onPressed: () {},
        child: Text(
          name,
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        tagname("#근처에"),
        tagname("#인기있는"),
        tagname("#새로운"),
        tagname("#관심있는"),
      ],
    );
  }
}
