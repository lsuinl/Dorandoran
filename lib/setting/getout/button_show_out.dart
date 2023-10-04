import 'package:dorandoran/setting/main/button_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:solar_icons/solar_icons.dart';

import '../../user/login/screen/kakao_login.dart';
import 'delete_account_closure.dart';

class ShowOutButton extends StatelessWidget {
  const ShowOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MenuButton(
        icons: SolarIconsOutline.roundedMagnifierZoomOut,
        text: "탈퇴하기",
        onPressed: (){
      showDialog(
          context: context,
          barrierDismissible: false,
          // 바깥 영역 터치시 닫을지 여부
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              content: Text(
                "탈퇴 시 모든 기록이 삭제됩니다. \n7일 이내에 재로그인 시 회원정보가 복구됩니다.\n탈퇴는 7일 이후 최종적으로 진행됩니다\n탈퇴하시겠습니까?",
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              actions: [
                TextButton(
                    onPressed: () async {
                      if (await DeleteAccountClosure() ==
                          200) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext
                                context) =>
                                    KaKaoLogin()),
                                (route) => false);
                        Fluttertoast.showToast(
                            msg: '탈퇴가 완료되었습니다');
                      } else {
                        print("에러");
                      }
                    },
                    child: Text(
                      "확인",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!,
                    ),
                    style: TextButton.styleFrom(
                      primary: Colors.black54,
                      side: BorderSide(
                        color: Colors.black54,
                      ),
                    )),
                TextButton(
                    onPressed: () =>
                        Navigator.pop(context),
                    child: Text(
                      "취소",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!,
                    ),
                    style: TextButton.styleFrom(
                        primary: Colors.black54,
                        side: BorderSide(
                          color: Colors.black54,
                        ))),
              ],
            );
          });
    });
  }
}
