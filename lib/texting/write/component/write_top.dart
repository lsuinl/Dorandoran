import 'package:dorandoran/texting/loding.dart';
import 'package:dorandoran/texting/write/quest/post.dart';
import 'package:dorandoran/common/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../screen/write.dart';
import 'write_middlefield.dart';


class Top extends StatelessWidget {
  //완료(글보내기)
  const Top({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topRight,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(	//모서리를 둥글게
                  borderRadius: BorderRadius.circular(10),
                side:BorderSide(color: Colors.white,width:1)
              ),
                primary: Colors.lightBlueAccent,
              minimumSize: Size(70, 40)
            ),
            onPressed: () async {
              String? locations;
              MultipartFile? userimage;
              if (usinglocation) {
                locations = '${latitude},${longtitude}';
              } else {
                locations = "";
              }
              if (dummyFille != null) {
                userimage = await MultipartFile.fromFile(dummyFille!.path,
                    filename: dummyFille!.path.split('/').last);
              } else {
                userimage = null;
              }
              if (contextcontroller.text != '') {
                writing(
                  useremail!,
                  contextcontroller.text,
                  forme,
                  locations,
                  backgroundimgname,
                  hashtag == [] ? null : hashtag,
                  userimage,
                  style.fontFamily.toString(),
                  style.color==Colors.white?"white":"black",
                  style.fontSize!.toInt(),
                 int.parse(style.fontWeight.toString().substring(12)),
                  anony
                );
                print(
                    "useremail:${useremail}\ncontext:${contextcontroller.text}\nforme:${forme}\nLocation: ${locations}\nbackimg:${backgroundimgname}\nhashtag${hashtag}\n filename:${dummyFille}");
                print("fontfamily ${style.fontFamily}\n color ${style.color.toString()}\n fontSize ${style.fontSize!.toInt()}\n fontWeight ${int.parse(style.fontWeight.toString().substring(12))}");
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    //애니매이션제거
                    pageBuilder: (BuildContext context,
                        Animation<double> animation1,
                        Animation<double> animation2) {
                      return loding();
                    },
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              }
            },
            child: Text("완료"),
        ));
  }
}
