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
          child: SizedBox(
              height: 70.h,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyLarge!),
                          Text(
                            createTime,
                            style: Theme.of(context).textTheme.bodySmall,
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
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios),
                        ],
                      )
                    ],
                  ))),
        )),
      ],
    );
  }
}
