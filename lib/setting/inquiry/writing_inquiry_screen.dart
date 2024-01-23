import 'package:dorandoran/setting/inquiry/inquiry_screen.dart';
import 'package:dorandoran/setting/inquiry/quest/post_save_inquiry_post.dart';
import 'package:flutter/material.dart';
import 'package:dorandoran/common/basic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:solar_icons/solar_icons.dart';

class WritingInquiryScreen extends StatelessWidget {
  const WritingInquiryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController title = TextEditingController();
    TextEditingController content = TextEditingController();

    return Scaffold(
        body: Basic(
            widgets: SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      SolarIconsOutline.doubleAltArrowLeft,
                      size: 30.r,
                    )),
                Text("  문의하기", style: Theme.of(context).textTheme.headlineLarge),
                TextButton(
                    onPressed: () async {
                      if (title.text != "" && content.text != "") {
                        int check =
                            await PostSaveInquiryPost(title.text, content.text);
                        if (check == 201) {
                          Fluttertoast.showToast(msg: "작성이 완료되었습니다.");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const InquiryScreen()));
                        } else {
                          Fluttertoast.showToast(msg: "문제가 발생했습니다. 다시 시도해주세요.");
                        }
                      }
                    },
                    child: Text(
                      "완료",
                      style:Theme.of(context).textTheme.headlineMedium,
                    ))
              ],
            ),
            SizedBox(height: 10.h),
            TextFormField(
              controller: title,
              decoration: const InputDecoration(
                  hintText: "제목을 입력해주세요.",
                  border: OutlineInputBorder(borderSide: BorderSide.none)),
              style: Theme.of(context).textTheme.headlineLarge
            ),
            Container(
              height: 1,
              color: Colors.black26,
            ),
            Flexible(
                child: TextFormField(
                  controller: content,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecoration(
                      hintText: "내용 입력해주세요.",
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                  style: Theme.of(context).textTheme.headlineMedium
                ))
          ],
        ),
      ),
    )));
  }
}
