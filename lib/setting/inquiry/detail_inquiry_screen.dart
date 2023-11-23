import 'package:dorandoran/setting/inquiry/inquiry_screen.dart';
import 'package:dorandoran/setting/inquiry/model/inquiry_detail_model.dart';
import 'package:dorandoran/setting/inquiry/quest/del_inquiry_post.dart';
import 'package:dorandoran/setting/inquiry/quest/get_read_inquiry_post.dart';
import 'package:flutter/material.dart';
import 'package:dorandoran/common/basic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:solar_icons/solar_icons.dart';
import 'component/inquiry_comment_card.dart';

class DerailInquiryScreen extends StatelessWidget {
  final int id;

  const DerailInquiryScreen({
    required this.id,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Basic(
            widgets: FutureBuilder(
                future: GetReadInquiryPost(id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                   InquiryDetailModel data =snapshot.data!;
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Padding(
                            padding: EdgeInsets.all(20),
                            child: SingleChildScrollView(
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
                                          SolarIconsOutline.doubleAltArrowLeft,
                                          size: 30.r,
                                        )),
                                      Text(" 문의상세보기",
                                          style: TextStyle(fontSize: 24.sp)),
                                    TextButton(
                                        onPressed: () async {
                                          int stat = await DelInquiryPost(id);
                                          if(stat==204){
                                            Fluttertoast.showToast(msg: "성공적으로 삭제되었습니다.");
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>InquiryScreen()));
                                          }
                                          else if(stat==403){
                                            Fluttertoast.showToast(msg: "답변이 완료된 문의글은 삭제할 수 없습니다.");
                                          }
                                          else{
                                            Fluttertoast.showToast(msg: "작업을 진행하는 데 문제가 발생했습니다. 다시 시도해주세요.");
                                          }
                                        }, child: Text("삭제", style: Theme.of(context).textTheme.headlineMedium!,))
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                Text('제목: ${data.title}',style:  Theme.of(context).textTheme.headlineLarge!,),
                                SizedBox(height: 10.h),
                                Text('작성자: ${data.memberEmail}',style:  Theme.of(context).textTheme.bodyMedium),
                                SizedBox(height: 10.h),
                                Text('작성 시간: ${data.postCreateTime}',style:  Theme.of(context).textTheme.bodyMedium),
                                SizedBox(height: 10.h),
                                Container(
                                  height: 1,
                                  color: Theme.of(context).brightness==Brightness.dark?Colors.white:Colors.black,
                                ),
                                SizedBox(height: 10.h),
                                Text(data.content,style:  Theme.of(context).textTheme.bodySmall),
                                SizedBox(height: 10.h),
                                Container(
                                  height: 1,
                                  color: Theme.of(context).brightness==Brightness.dark?Colors.white:Colors.black,
                                ),
                                SingleChildScrollView(
                                  child:
                                  Column(
                                    children: data.inquiryCommentList.map((e) => InquiryCommentCard(e: e)).toList())
                                  ),
                              ],
                            )),
                          ));
                  } else {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Center(child: CircularProgressIndicator()));
                  }
                })));
  }
}
