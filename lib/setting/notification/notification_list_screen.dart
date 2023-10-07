import 'package:dorandoran/common/basic.dart';
import 'package:dorandoran/common/model/all_notification_model.dart';
import 'package:dorandoran/setting/notification/get_notification.dart';
import 'package:dorandoran/setting/notification/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_icons/solar_icons.dart';

import '../post_storage/my_list_top.dart';

class NotificationListScreen extends StatelessWidget {
  const NotificationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Basic(
            widgets: FutureBuilder(
                future: GetNotification(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<AllNotificationModel> datas = snapshot.data;

                    return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: SingleChildScrollView(
                            child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: Icon(
                                              SolarIconsOutline
                                                  .doubleAltArrowLeft,
                                              size: 30.r,
                                            )),
                                        Row(children: [
                                          Text(" 공지사항",
                                              style:
                                                  TextStyle(fontSize: 24.sp)),
                                        ]),
                                        Container(
                                          width: 50.w,
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    Column(
                                      children: datas.map((e) =>
                                        NotificationCard(
                                            id: e.notificationId,
                                            title: e.title,
                                            createdTime:e.createdTime)
                                      ).toList()
                                    )
                                  ],
                                ))));
                  }
                  else{
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child:Center(child: CircularProgressIndicator()));
                  }
                })));
  }
}
