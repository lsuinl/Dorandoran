import 'package:dorandoran/common/basic.dart';
import 'package:dorandoran/setting/inquiry/inquiry_screen.dart';
import 'package:dorandoran/setting/nickname_change/button_change_nickname.dart';
import 'package:dorandoran/setting/main/button_menu.dart';
import 'package:dorandoran/setting/notice/get_notice.dart';
import 'package:dorandoran/setting/notice/patch_notice.dart';
import 'package:dorandoran/setting/post_storage/my_list_screen.dart';
import 'package:dorandoran/setting/getout/button_show_out.dart';
import 'package:dorandoran/setting/main/top.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solar_icons/solar_icons.dart';
import '../../common/theme_provider.dart';
import '../../common/util.dart';
import '../../main.dart';
import '../notification/notification_list_screen.dart';

class SettingListScreen extends StatefulWidget {
  const SettingListScreen({super.key});

  @override
  State<SettingListScreen> createState() => _SettingListScreenState();
}

class _SettingListScreenState extends State<SettingListScreen> {
bool isNotice=false;
bool isDark=false;
@override
void initState() {
    // TODO: implement initState
  SchedulerBinding.instance!.addPostFrameCallback((_) {
    noticeset();
  });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Basic(
        widgets: Container(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Top(),
                    Flexible(child: ChangeNicknameButton()),
                    Flexible(
                        fit: FlexFit.tight,
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Icon(SolarIconsOutline.bell),
                                  SizedBox(width: 10.w,),
                                  Text("알림",style:Theme.of(context).textTheme.headlineMedium!,),
                                ]),
                                CupertinoSwitch(
                                    value: isNotice,
                                    onChanged: (bool value) async {
                                      int check = await PatchNotice();
                                      if(check==204) {
                                        setState(() {
                                          isNotice = value;
                                        });
                                      }
                                      else
                                        Fluttertoast.showToast(msg: "설정 도중에 문제가 발생했습니다. 잠시 후에 다시 시도해주세요.");
                                      }),
                              ],))),
                    Flexible(
                        fit: FlexFit.tight,
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Icon(SolarIconsOutline.moon),
                                  SizedBox(width: 10.w,),
                                  Text("다크모드",style: TextStyle(fontSize: 18.sp)),
                                ]),
                                CupertinoSwitch(
                                    value: isDark,
                                    onChanged: (bool value) async {
                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                      setState(() {
                                        if(value==true) {
                                          final themeProvider =
                                          Provider.of<ThemeProvider>(context, listen: false);
                                          themeProvider.setThemeMode(ThemeMode.dark);
                                          prefs.setBool("DarkMode", true);
                                        }
                                        else{
                                          final themeProvider =
                                          Provider.of<ThemeProvider>(context, listen: false);
                                          themeProvider.setThemeMode(ThemeMode.light);
                                          prefs.setBool("DarkMode", false);
                                        }
                                        isDark = value;
                                      });
                                    }),
                              ],))),
                    Flexible(
                        fit: FlexFit.tight,
                        child: MenuButton(
                            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MyListScreen(text: "내가 쓴 글"))),
                            icons: SolarIconsOutline.pen,
                            text: "내가 쓴 글",)),
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
                            onPressed: () =>Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationListScreen())),
                            icons: Icons.campaign_outlined,
                            text: "공지사항")),
                    Flexible(
                        fit: FlexFit.tight,
                        child: MenuButton(
                            onPressed: () =>Navigator.push(context, MaterialPageRoute(builder: (context) => InquiryScreen())),
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
                              Text("1.0.0",style:Theme.of(context).textTheme.headlineMedium!),
                            ]
                            ))
                    )],
                )));
  }

 void noticeset() async {
    bool check = await GetNotice();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? dartcheck = prefs.getBool("DarkMode");
    setState(() {
      isDark=dartcheck ?? false;
      isNotice =check;
    });
 }
}
