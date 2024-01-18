import 'package:dorandoran/common/basic.dart';
import 'package:dorandoran/notice/component/notice_card.dart';
import 'package:dorandoran/notice/model/notice_model.dart';
import 'package:dorandoran/notice/quest/del_notice.dart';
import 'package:dorandoran/notice/quest/get_search_notice.dart';
import 'package:dorandoran/notice/quest/patch_read_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../common/css.dart';
import 'component/top.dart';

class NoticeScreen extends StatefulWidget {
  const NoticeScreen({super.key});

  @override
  State<NoticeScreen> createState() => _NoticeScreenState();
}
Map<int, bool> isRead ={};
class _NoticeScreenState extends State<NoticeScreen> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  List<Widget> item = [];
  int lastnumber=0;

  @override
  Widget build(BuildContext context) {
    return Basic(
        widgets: Scaffold(
            body: Container(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black26
                    : backgroundcolor,
                child: SafeArea(
                    top: true,
                    bottom: true,
                    child: FutureBuilder(
                        future: GetSearchNotice(lastnumber),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data!.runtimeType!=int) {
                            List<noticeModel> data = snapshot.data!;
                            List<int> idList = data.map((e) => e.notificationId).toList();
                            data.map((e) => isRead[e.notificationId]=e.isRead);
                            lastnumber=idList.last;
                            item.addAll(data
                                .map((e) => SwipeActionCell(
                                    key: ObjectKey(e.notificationId),
                                    trailingActions: e.notificationId == true
                                        ? [
                                            //삭제
                                            SwipeAction(
                                                icon: Icon(Icons.delete,
                                                    size: 30.r),
                                                onTap: (CompletionHandler
                                                    handler) async {
                                                  await handler(true);
                                                  //  item.removeAt();
                                                  deleteNotification(
                                                      true, e.notificationId);
                                                  setState(() {
                                                    isRead[e.notificationId] =true;
                                                    GetSearchNotice(lastnumber);
                                                  });
                                                },
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark
                                                    ? Colors.black26
                                                    : const Color(0xFFD9D9D9))
                                          ]
                                        : [
                                            //삭제,읽음
                                            SwipeAction(
                                                icon: Icon(Icons.check,
                                                    size: 30.r),
                                                onTap: (CompletionHandler
                                                    handler) async {
                                                  deleteNotification(
                                                      false, e.notificationId);
                                                  setState(() {
                                                    GetSearchNotice(lastnumber);
                                                  });
                                                },
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark
                                                    ? Colors.black26
                                                    : const Color(0xFFD9D9D9)),
                                            SwipeAction(
                                                icon: Icon(Icons.delete,
                                                    size: 30.r),
                                                onTap: (CompletionHandler
                                                    handler) async {
                                                  await handler(true);
                                                  deleteNotification(
                                                      true, e.notificationId);
                                                  setState(() {
                                                    GetSearchNotice(lastnumber);
                                                  });
                                                },
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark
                                                    ? Colors.black26
                                                    : const Color(0xFFD9D9D9))
                                          ],
                                    child: NoticeCard(
                                        notificationId: e.notificationId,
                                        title: e.title,
                                        message: e.message,
                                        notificationTime: e.notificationTime,
                                        notificationType: e.notificationType)))
                                .toList());

                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Top(
                                    idlists: idList,
                                    rebuild: rebuild,
                                  ),
                                  Expanded(
                                      child: SmartRefresher(
                                          controller: _refreshController,
                                          enablePullDown: false,
                                          enablePullUp: true,
                                          onLoading: () async {
                                            print("로딩즁");
                                            _refreshController.loadComplete();
                                          },
                                          child: item.length == 0
                                              ? Center(
                                                  child: Text("조회된 알림내역이 없습니다.",
                                                      style: TextStyle(
                                                          fontSize: 20.sp)))
                                              : SingleChildScrollView(
                                                  child:
                                                      Column(children: item))))
                                ]);
                          } else {
                            return Center(
                                child: const CircularProgressIndicator());
                          }
                        })))));
  }

//일부삭제
  deleteNotification(bool delete, int notificationId) async {
    if (delete == true) {
      int code = await DelNotice(notificationId);
      if (code == 204) Fluttertoast.showToast(msg: '삭제가 완료되었습니다.');
    } else {
      int code = await PatchReadNotice([notificationId]);
      if (code == 204) Fluttertoast.showToast(msg: '읽음처리가 완료되었습니다.');
    }
  }

  rebuild() {
    Navigator.pop(context);
    Navigator.push(
            context, MaterialPageRoute(builder: (context) => NoticeScreen()))
        .then((value) => setState(() {}));
  }
}
