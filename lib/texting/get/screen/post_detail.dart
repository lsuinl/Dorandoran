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
              child: SafeArea(
                  child: Padding(
                  padding: const EdgeInsets.all(20),
                child:
                Column(
                  children: [
                    // snapshot.data!.map<Detail_Card>((e)=>Detail_Card(
                    //     content: e.content,
                    //     postTime: e.postTime,
                    //     location: e.location,
                    //     postLikeCnt: e.postLikeCnt,
                    //     postLikeResult: e.postLikeResult,
                    //     commentCnt: e.commentCnt,
                    //     backgroundPicUri: e.backgroundPicUri,
                    //     postHashes: e.postHashes
                    // ))
                  ],
            )
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

class Detail_Card extends StatelessWidget {
  final String content;
  final String postTime;
  final String? location;
  final int postLikeCnt;
  final bool? postLikeResult;
  final int commentCnt;
  final String backgroundPicUri;
  final List<dynamic>? postHashes;

  const Detail_Card({
    required this.content,
    required this.postTime,
    required this.location,
    required this.postLikeCnt,
    required this.postLikeResult,
    required this.commentCnt,
    required this.backgroundPicUri,
    required this.postHashes,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
