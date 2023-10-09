import 'package:dorandoran/common/quest_token.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../texting/home/home.dart';
import '../quest/post_write_post.dart';
import '../screen/write.dart';
import 'write_middlefield.dart';

class PostButton extends StatelessWidget {

  const PostButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topRight,
        child: IconButton(
          onPressed: () async {
            MultipartFile? userimage;

            if (dummyFille != null)
              userimage = await MultipartFile.fromFile(dummyFille!.path, filename: dummyFille!.path.split('/').last);

            if (contextcontroller.text != '') {
              int postcheck = await PostWritePost(
                  contextcontroller.text,
                  forme,
                  usinglocation,
                  backgroundimgname,
                  taglistname==[]?null:taglistname,
                  userimage,
                  setfont(),
                  style.color == Colors.white ? "white" : "black",
                  style.fontSize!.toInt(),
                  int.parse(style.fontWeight.toString().substring(12)), anony);

              if(postcheck==201)
                Navigator.push(context, PageRouteBuilder(pageBuilder: (BuildContext context, Animation<double> animation1, Animation<double> animation2) {return Home();},),);
              else {
                if(postcheck==415)
                  Fluttertoast.showToast(msg: "형식에 맞지 않는 이미지입니다.");
                else if(postcheck==403)
                  Fluttertoast.showToast(msg: "작성이 정지된 상태입니다.");
                else
                   Fluttertoast.showToast(msg: "전송에 오류가 발생하였습니다 다시 시도해주세요.");
              }
            }
          },
          icon: Icon(Icons.check,size: 30.r,),
        ));
  }

  String setfont(){
    String fontfamily;
    if (style.fontFamily.toString().contains("Jua")) fontfamily = "Jua";
    else if (style.fontFamily.toString().contains("NanumGothic")) fontfamily = "Nanum Gothic";
    else fontfamily = "Cute Font";

    return fontfamily;
  }


}
