import 'package:dorandoran/setting/inquiry/component/inquiry_card.dart';
import 'package:dorandoran/setting/inquiry/component/writing_button.dart';
import 'package:dorandoran/setting/inquiry/model/inquiry_model.dart';
import 'package:dorandoran/setting/inquiry/quest/get_inquiry_postlist.dart';
import 'package:dorandoran/setting/main/setting_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:dorandoran/common/basic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_icons/solar_icons.dart';


class InquiryScreen extends StatelessWidget {
  const InquiryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Basic(
            widgets: FutureBuilder(
                future: GetInquiryPostList(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<InquiryModel> datas = snapshot.data;
                    return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Stack(children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        onPressed: () =>Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const SettingListScreen()),(route)=>false),
                                        icon: Icon(
                                          SolarIconsOutline.doubleAltArrowLeft,
                                          size: 30.r,
                                        )),
                                    Row(children: [
                                      Text(" 문의내역",
                                          style: TextStyle(fontSize: 24.sp)),
                                    ]),
                                    Container(
                                      width: 50.w,
                                    )
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                SingleChildScrollView(
                                    child: Column(
                                        children: datas.isNotEmpty
                                            ? datas
                                                .map((e) => InquiryCard(
                                            id: e.inquiryPostId,
                                            title: e.title,
                                            createTime:e.createTime,
                                            inquiryStatus: e.inquiryStatus))
                                                .toList()
                                            : [const Center(child: Text("작성된 문의글이 없습니다."))]))
                              ],
                            ),
                          ),
                          const WritingButton()
                        ]));
                  } else {
                    return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: const Center(child: CircularProgressIndicator()));
                  }
                })));
  }
}
