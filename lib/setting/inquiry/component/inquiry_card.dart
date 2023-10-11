import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../detail_inquiry_screen.dart';

class InquiryCard extends StatelessWidget {
  final int id;
  final String title;
  final String createTime;
  final String inquiryStatus;

  const InquiryCard(
      {required this.id,
      required this.title,
      required this.createTime,
      required this.inquiryStatus,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
            child: InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DerailInquiryScreen(
                        id: id,
                      ))),
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
                            child: Text(title,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600)),
                          ),
                          Text(
                            createTime,
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 80.w,
                            height: 25.h,
                            decoration: BoxDecoration(
                                color: inquiryStatus == "NotAnswered"
                                    ? Colors.red
                                    : Colors.green,
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              inquiryStatus,
                              style: TextStyle(color: Colors.white,fontSize: 10.sp),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios),
                        ],
                      )
                    ],
                  ))),
        )),
        SizedBox(height: 10.h)
      ],
    );
  }
}
