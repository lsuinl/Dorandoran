import 'dart:io';
import 'dart:math';
import 'package:dorandoran/user/sign_up/permission.dart';
import 'package:dorandoran/common/storage.dart';
import 'package:dorandoran/texting/get/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import '../../../common/css.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dorandoran/common/uri.dart';

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
Set<int> imagenumber={0,1,2,3,4,5,6,7,8,9};

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
                                        print("useremail:${useremail}\ncontext:${contextcontroller.text}\nforme:${forme}\nLocation: ${latitude},${longtitude}\nbackimg:${backgroundimgname}\nhashtag${hashtag}\n filename:${dummyFille}");
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
                                    child: TextFormField(
                                      style: TextStyle(fontSize: 20.sp),
                                      maxLines: 100,
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
                                          height: 200.h,
                                          color: Colors.white70,
                                          child: Column(
                                              children: <Widget>[
                                                Column(
                                                  children: [
                                                    IconButton(
                                                        onPressed: (){
                                                          //이미지 리셋
                                                          imagenumber.clear();
                                                          while(imagenumber.length<10){
                                                            imagenumber.add(Random().nextInt(100));
                                                          }
                                                        },
                                                        icon: Icon(Icons.restart_alt)),
                                                    Wrap(
                                                      children: imagenumber.map((e)=>
                                                          Image.network(imgurl,width: 72.w,height: 72.h,),
                                                         //Image.network(imgurl+e.toString(),width: 72.w,height: 72.h,),
                                                      ).toList(),
                                                    ),
                                                  ],
                                                ),
                                              ],
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
