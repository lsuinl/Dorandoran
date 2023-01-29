import 'dart:io';
import 'package:dorandoran/const/permission.dart';
import 'package:dorandoran/const/storage.dart';
import 'package:dorandoran/model/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import '../const/css.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class Write extends StatefulWidget {
  const Write({Key? key}) : super(key: key);

  @override
  State<Write> createState() => _WriteState();
}


TextEditingController contextcontroller = TextEditingController();
bool forme = false;
File? dummyFille;
List<String>? hashtag;
String? backgroundimgname;
String? latitude, longtitude;

class _WriteState extends State<Write> {
  @override
  void initState() {
    permissionquest();
    getlocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          decoration: gradient,
          child: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text("글 작성하기", style: TextStyle(fontSize: 30.sp),),
                    Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                alignment: Alignment.topRight,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.black),
                                    onPressed: () {
                                      if(contextcontroller.text!=null &&(backgroundimgname!=null || dummyFille!=null)) {
                                        print('되었어요');
                                        // writing(
                                        //     useremail!,
                                        //     contextcontroller.text,
                                        //     forme,
                                        //     latitude,
                                        //     longtitude,
                                        //     backgroundimgname,
                                        //     hashtag,
                                        //     dummyFille
                                        // );
                                      }
                                    },
                                    child: Text("완료"))),
                            Container(
                              height: 300.h,
                              decoration: BoxDecoration(
                                border: Border.all(),
                              ),
                              child: ListView(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10,
                                        bottom: 10,
                                        left: 16,
                                        right: 16),
                                    child: TextField(
                                      style: TextStyle(fontSize: 20.sp),
                                      maxLines: null,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.black)),
                                        hintText: "내용을 작성해주세요",
                                        hintStyle:
                                        whitestyle.copyWith(
                                            color: Colors.black12),
                                      ),
                                      controller: contextcontroller,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        forme = !forme;
                                      });
                                      print(forme);
                                    },
                                    icon: forme ? Icon(Icons.lock) : Icon(
                                        Icons.lock_open)),
                                IconButton(
                                    onPressed: () {
                                      GetImageFile();
                                    },
                                    icon: Icon(Icons.image)),
                                IconButton(
                                  icon: Icon(Icons.grid_view),
                                  onPressed: () {
                                    showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          height: 200,
                                          color: Colors.white70,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Column(
                                                  children: [
                                                    Row(children: [
                                                      Text("a"),
                                                      Text("b"),
                                                      Text("c"),
                                                      Text("a"),
                                                      Text("b"),
                                                    ]),
                                                    Row(children: [
                                                      Text("a"),
                                                      Text("b"),
                                                      Text("c"),
                                                      Text("a"),
                                                      Text("b"),
                                                    ])
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                                IconButton(onPressed: () {}, icon: Icon(
                                    Icons.tag)),
                              ],
                            ),
                          ]),
                    ),
                  ],
                )),
          )),
    );
  }

  GetImageFile() async {
    XFile? f = await ImagePicker().pickImage(source: ImageSource.gallery);
    dummyFille = File(f!.path);
    print(dummyFille);
  }

  void getlocation() async {
    //현재위치 가져오기
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      latitude = position.latitude.toString();
      longtitude = position.longitude.toString();
    });
  }
}
