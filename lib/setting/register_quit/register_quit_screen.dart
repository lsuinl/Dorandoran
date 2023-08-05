import 'package:dorandoran/common/basic.dart';
import 'package:dorandoran/setting/register_quit/quest/delete_account_closure.dart';
import 'package:dorandoran/user/login/screen/kakao_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterQuitScreen extends StatelessWidget {
  const RegisterQuitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Basic(
        widgets:Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("탈퇴 시 모든 기록이 삭제됩니다. \n7일 이내에 재로그인 시 회원정보가 복구됩니다.\n탈퇴는 7일 이후 최종적으로 진행됩니다\n탈퇴하시겠습니까?",
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () async {
                      if(await DeleteAccountClosure()==200) {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                            builder: (BuildContext context) =>
                                KaKaoLogin()), (route) => false);
                        Fluttertoast.showToast(msg: '탈퇴가 완료되었습니다');
                      }
                      else{
                        print("에러");
                      }
                    },
                    child: Text("확인", style: Theme.of(context)
                        .textTheme
                        .labelSmall!,),
                    style: TextButton.styleFrom(
                        primary: Colors.black54,
                        side: BorderSide(
                          color: Colors.black54,
                        ))),
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("취소", style: Theme.of(context)
                        .textTheme
                        .labelSmall!,),
                    style: TextButton.styleFrom(
                        primary: Colors.black54,
                        side: BorderSide(
                          color: Colors.black54,
                        ))),
              ],
            )
          ],
        )
    );
  }
}
