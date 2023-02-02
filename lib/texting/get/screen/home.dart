import 'package:dorandoran/common/css.dart';
import 'package:dorandoran/common/storage.dart';
import 'package:dorandoran/texting/get/post.dart';
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
late Future myfuture;
List<Message_Card>? item;
int? checknumber;

@override
void initState(){
  super.initState();
  myfuture=getPostContent(useremail,0,'mmmmmm');
}
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: backgroundcolor,
        body: FutureBuilder(
          future: myfuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              int lastnumber=snapshot.data!.last.postId;
              if(item==null){
               item= snapshot.data!.map<Message_Card>((e) =>
                    Message_Card(time: e.postTime,
                        heart: e.likeCnt,
                        chat: e.replyCnt,
                        map: e.location,
                        message: e.contents
                    )
                ).toList();
              }
              else{
                if(checknumber!=lastnumber) {
                  item!.addAll(snapshot.data!.map<Message_Card>((e) =>
                      Message_Card(time: e.postTime,
                          heart: e.likeCnt,
                          chat: e.replyCnt,
                          map: e.location,
                          message: e.contents
                      )
                  ).toList());
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
                                  builder: (BuildContext context, LoadStatus) {
                                    return Container(
                                      height: 55.0,
                                      child: Center(child: Text("")),
                                    );
                                  },
                                ),
                                onRefresh: () async {
                                  await Future.delayed(Duration(
                                      milliseconds: 1000)); //1초를 기다린 후 새로고침한다.
                                  setState(() {
                                    item!.clear();
                                    myfuture = getPostContent(useremail,0,'mmmmmm');
                                  });
                                  print('새로고침');
                                  _refreshController.refreshCompleted();
                                },
                                // 새로고침
                                onLoading: //무한 스크롤
                                    () async {
                                  await Future.delayed(Duration(
                                      milliseconds: 1000)); //1초를 기다린 후 새로운 데이터를 불러온다.
                                  if(lastnumber-1>0) {
                                    setState(() {
                                      myfuture = getPostContent(
                                          useremail, lastnumber - 1, 'mmmmmm');
                                      checknumber = lastnumber;
                                    });
                                    _refreshController.loadComplete();
                                  }
                                },
                                controller: _refreshController,
                                child: ListView(
                                  children: item!.map<Widget>((e) =>
                                   e
                                  ).toList(),
                                ),
                              ),
                            )
                          ],
                        ),
                        BottomButton()
                      ]),
                    ),
                  ),
                ),
              );
            }
            else {
              return CircularProgressIndicator();
            }
          }
          )
    );
  }


}
//---------------------------------------------------
class Message_Card extends StatelessWidget {
  final String time;
  final int heart;
  final int? chat;
  final int map;
  final String message;

  const Message_Card(
      {required this.time,
      required this.heart,
      required this.chat,
      required this.map,
      required this.message,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      elevation: 2, //그림자
      color: Colors.white70,
      child: InkWell(
        onTap: (){
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Main_Text()));
        },
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
                    child: Text(message,
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
                      Text(timecount(time)),
                      SizedBox(width: 7.w),
                      Icon(Icons.place),
                      Text('${map}km'),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.favorite),
                        constraints: BoxConstraints(),
                        padding: EdgeInsets.zero,
                      ),
                      SizedBox(width: 3.w),
                      Text('${heart}'),
                      SizedBox(width: 7.w),
                      Icon(Icons.forum),
                      SizedBox(width: 3.w),
                      Text('${chat}'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10.h),
            ],
          ),
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

class BottomButton extends StatelessWidget {
  const BottomButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          RawMaterialButton(
            onPressed: () {
              getPostContent(useremail,0,'mmmmmm');
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
                  context, MaterialPageRoute(builder: (context) => Write()));
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
    );
  }
}
