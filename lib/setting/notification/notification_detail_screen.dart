import 'package:dorandoran/common/basic.dart';
import 'package:dorandoran/common/model/all_notification_model.dart';
import 'package:dorandoran/common/model/notification_model.dart';
import 'package:dorandoran/setting/notification/get_detail_notification.dart';
import 'package:dorandoran/setting/notification/get_notification.dart';
import 'package:dorandoran/setting/notification/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_icons/solar_icons.dart';

import '../post_storage/my_list_top.dart';

class NotificationDetailScreen extends StatelessWidget {
  final int id;

  const NotificationDetailScreen({
    required this.id,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Basic(
            widgets: FutureBuilder(
                future: GetDetailNotification(id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    NotificationModel data = snapshot.data!;
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: SingleChildScrollView(
                            child: Padding(
                                padding: EdgeInsets.all(0),
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
                                      Text(data.title,
                                          style:
                                          TextStyle(fontSize: 24.sp,fontWeight: FontWeight.w600)),
                                    ]),
                                    Container(
                                      width: 50.w,
                                    )
                                  ],
                                  ),
                                    // Text(data.title, style: TextStyle(fontSize: 30.sp,fontWeight: FontWeight.w600),),
                                    SizedBox(height:10.h),
                                    Text(data.content,style: TextStyle(fontSize: 15.sp,)),
                                    SizedBox(height:10.h),
                                    Text(data.createdTime,style: TextStyle(fontSize: 12.sp,))
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
