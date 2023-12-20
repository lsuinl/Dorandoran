import 'package:dorandoran/common/basic.dart';
import 'package:dorandoran/notice/component/notice_card.dart';
import 'package:dorandoran/notice/model/notice_model.dart';
import 'package:dorandoran/notice/quest/get_search_notice.dart';
import 'package:flutter/material.dart';
import '../common/css.dart';
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
    return Basic(widgets:
      Scaffold(
        body: Container(
          color: Theme.of(context).brightness==Brightness.dark?Colors.black26:backgroundcolor,
            child: SafeArea(
                top: true,
                bottom: true,
                child: FutureBuilder(
                  future:GetSearchNotice(0),
                  builder: (context, snapshot){
                    if(snapshot.hasData) {
                      List<noticeModel> data=snapshot.data!;
                      if(item.isEmpty) {
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
                      return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Top(),
                                    Flexible(child:
                                   SingleChildScrollView(
                                          child:
                                        Column(children: item)
                                    )
                                    )
                                  ]);
                    }
                    else{
                      return const CircularProgressIndicator();
                    }
                    }
    )))));
  }
}
