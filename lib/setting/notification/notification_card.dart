import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'notification_detail_screen.dart';

class NotificationCard extends StatelessWidget {
  final int id;
  final String title;
  final String createdTime;

  const NotificationCard(
      {required this.id,
        required this.title,
        required this.createdTime,
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
            child: InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(
                      builder: (context) => NotificationDetailScreen(id: id))),
              child: Container(
                  height: 60.h,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Stack(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child:Text(
                                    title,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600)),
                              ),
                              Text(
                                createdTime.substring(0,10),
                                style: TextStyle(color: Colors.black54),
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.arrow_forward_ios),
                          )
                        ],
                      ))),
            )),
        SizedBox(height: 10.h)
      ],
    );
  }
}