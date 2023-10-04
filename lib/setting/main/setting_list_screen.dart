import 'package:dorandoran/notice/notice_screen.dart';
import 'package:dorandoran/setting/nickname_change/button_change_nickname.dart';
import 'package:dorandoran/setting/main/button_menu.dart';
import 'package:dorandoran/setting/post_storage/my_list_screen.dart';
import 'package:dorandoran/setting/getout/button_show_out.dart';
import 'package:dorandoran/setting/main/top.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_icons/solar_icons.dart';
import '../../common/css.dart';
import '../notification/notification_list_screen.dart';

class SettingListScreen extends StatelessWidget {
  const SettingListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: backgroundcolor,
            child: SafeArea(
                top: true,
                bottom: true,
                child: Container(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Top(),
                    Flexible(child: ChangeNicknameButton()),
                    Flexible(
                        fit: FlexFit.tight,
                        child: MenuButton(
                            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MyListScreen(text: "내가 쓴 글"))),
                            icons: SolarIconsOutline.pen,
                            text: "내가 쓴 글")),
                    Flexible(
                        fit: FlexFit.tight,
                        child: MenuButton(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MyListScreen(text: "좋아요 한 글"))),
                          icons: SolarIconsOutline.heart,
                          text: "내가 좋아요 한 글",
                        )),
                    Flexible(
                        fit: FlexFit.tight,
                        child: MenuButton(
                            onPressed: () {},
                            icons: SolarIconsOutline.settings,
                            text: "설정")),
                    Flexible(
                        fit: FlexFit.tight,
                        child: MenuButton(
                            onPressed: () =>Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationListScreen())),
                            icons: Icons.campaign_outlined,
                            text: "공지사항")),
                    Flexible(
                        fit: FlexFit.tight,
                        child: MenuButton(
                            onPressed: () {},
                            icons: SolarIconsOutline.callChat,
                            text: "문의하기")),
                    Flexible(fit: FlexFit.tight, child: ShowOutButton()),
                    Flexible(
                        fit: FlexFit.tight,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10,right: 20),
                      child:  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(child: Icon(SolarIconsOutline.home,size: 24.r,)),
                                    TextSpan(text: '  앱 버전',style: TextStyle(fontSize: 18.sp)),
                                  ],
                                ),
                              ),
                              Text("1.0.0",style: TextStyle(fontSize: 18.sp)),
                            ]
                            ))
                    )],
                )))));
  }
}
