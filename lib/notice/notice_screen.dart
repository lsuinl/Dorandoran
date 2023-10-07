import 'package:dorandoran/hash/search/quest/get_search_hash.dart';
import 'package:dorandoran/notice/component/notice_card.dart';
import 'package:dorandoran/notice/model/notice_model.dart';
import 'package:dorandoran/notice/quest/get_read_notice.dart';
import 'package:dorandoran/notice/quest/get_search_notice.dart';
import 'package:flutter/material.dart';
import '../common/css.dart';
import '../texting/home/home.dart';
import 'component/top.dart';

class NoticeScreen extends StatefulWidget {
  const NoticeScreen({super.key});

  @override
  State<NoticeScreen> createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  List<Widget> item=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: backgroundcolor,
            child: SafeArea(
                top: true,
                bottom: true,
                child: FutureBuilder(
                  future:GetSearchNotice(0),
                  builder: (context, snapshot){
                    if(snapshot.hasData) {
                      List<noticeModel> data=snapshot.data!;
                      if(item.length<1) {
                        item.addAll(
                            data.map((e) =>
                                NoticeCard(notificationId: e.notificationId,
                                    title: e.title,
                                    message: e.message,
                                    notificationTime: e.notificationTime,
                                    isRead: e.isRead,
                                    notificationType: e.notificationType
                                )
                            ).toList()
                        );
                      }
                      return Container(
                          child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Top(),
                                    Flexible(child:
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 20, top: 20, bottom: 20),
                                        child:SingleChildScrollView(
                                          child:
                                        Column(children: item)
                                        )
                                    )
                                    )
                                  ])));
                    }
                    else{
                      return CircularProgressIndicator();
                    }
                    }
    ))));
  }
}
