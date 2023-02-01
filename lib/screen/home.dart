import 'package:dorandoran/const/css.dart';
import 'package:dorandoran/model/post.dart';
import 'package:dorandoran/screen/maintext.dart';
import 'package:dorandoran/screen/write.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:dorandoran/model/postcard.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundcolor,
        body: FutureBuilder(
          future: getPostContent(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
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
                              child: ListView(
                                children:
                                snapshot.data!.map((e) =>
                                    Message_Card(time: e.postTime,
                                        heart: e.likeCnt,
                                        chat: e.replyCnt,
                                        map: e.location,
                                        message: e.contents
                                    )
                                ).toList(),
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
          }));
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
              getPostContent();
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
