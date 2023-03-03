import 'package:dorandoran/common/css.dart';
import 'package:dorandoran/texting/get/component/message_card.dart';
import 'package:dorandoran/texting/get/quest/get_post_detail.dart';
import 'package:flutter/material.dart';

class PostDetail extends StatelessWidget {
  const PostDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getpostDetail(4,"7@gmail.com", ""),
          builder:(context, snapshot) {
          if(snapshot.hasData){
            return Container(
              alignment: Alignment.center,
              decoration: gradient,
              child:Center(
             child: Column(
                children: [
                  Text("일단네"),
                ],
              )
            )
            );
          }
          else{
            return Container(
                decoration: gradient,
                child: Center(child: CircularProgressIndicator()));
          }
          }
    )
      );
  }
}
