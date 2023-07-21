import 'package:dorandoran/texting/write/quest/post_write_post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../loding.dart';
import '../screen/write.dart';
import 'write_middlefield.dart';

class PostButton extends StatelessWidget {
  //완료(글보내기)
  const PostButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topRight,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),  //모서리를 둥글게
                  side: BorderSide(color: Colors.white, width: 1)),
              primary: Colors.lightBlueAccent,
              minimumSize: Size(70, 40)),
          onPressed: () async {
            MultipartFile? userimage;
            String? fontfamily;

            if (style.fontFamily.toString().contains("Jua"))
              fontfamily = "Jua";
            else if (style.fontFamily.toString().contains("NanumGothic"))
              fontfamily = "Nanum Gothic";
            else
              fontfamily = "Cute Font";

            //배경화면 지정하기
            if (dummyFille != null) {
              userimage = await MultipartFile.fromFile(dummyFille!.path,
                  filename: dummyFille!.path.split('/').last);
            } else
              userimage = null;

            if (contextcontroller.text != '') {
              PostWritePost(
                  contextcontroller.text,
                  forme,
                  usinglocation,
                  backgroundimgname,
                  hashtag == [] ? null : hashtag,
                  userimage,
                  fontfamily,
                  style.color == Colors.white ? "white" : "black",
                  style.fontSize!.toInt(),
                  int.parse(style.fontWeight.toString().substring(12)), anony);
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (BuildContext context, Animation<double> animation1, Animation<double> animation2) {
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
