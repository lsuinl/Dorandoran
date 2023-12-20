import 'package:dorandoran/setting/main/button_menu.dart';
import 'package:flutter/material.dart';
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
              backgroundColor:Theme.of(context).brightness==Brightness.dark?Colors.black26:Colors.white,
              content: Text(
                "탈퇴 시 모든 기록이 삭제됩니다. \n7일 이내에 재로그인 시 회원정보가 복구됩니다.\n탈퇴는 7일 이후 최종적으로 진행됩니다\n탈퇴하시겠습니까?",
                style: Theme.of(context).textTheme.bodyMedium!,
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
                                    const KaKaoLogin()),
                                (route) => false);
                        Fluttertoast.showToast(
                            msg: '탈퇴가 완료되었습니다');
                      } else {
                      }
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black54, side: const BorderSide(
                        color: Colors.black54,
                      ),
                    ),
                    child: Text(
                      "확인",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!,
                    )),
                TextButton(
                    onPressed: () =>
                        Navigator.pop(context),
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.black54, side: const BorderSide(
                          color: Colors.black54,
                        )),
                    child: Text(
                      "취소",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!,
                    )),
              ],
            );
          });
    });
  }
}
