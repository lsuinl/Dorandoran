import 'package:dorandoran/setting/write_from_me/component/my_list_card.dart';
import 'package:dorandoran/setting/write_from_me/quest/get_all_posts.dart';
import 'package:flutter/material.dart';
import 'package:dorandoran/common/css.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../common/basic.dart';


class WriteFromMeScreen extends StatefulWidget {

  const WriteFromMeScreen({
    Key? key}) : super(key: key);

  @override
  State<WriteFromMeScreen> createState() => _WriteFromMeScreenState();
}
class _WriteFromMeScreenState extends State<WriteFromMeScreen> {
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  ScrollController scrollController = ScrollController();
  late Future myfuture;
  List<MyListCard>? item;
  int? checknumber;

  @override
  void initState() {
    super.initState();
    setState(() {
      _refreshController = RefreshController(initialRefresh: false);
      scrollController = ScrollController();
    });
    myfuture = GetAllPosts(0);
  }

  @override
  Widget build(BuildContext context) {
    return Basic(
        widgets: FutureBuilder(
            future: myfuture,
            builder: (context, snapshot) {
              print(snapshot.runtimeType);
              if (snapshot.hasData) {
                int lastnumber = snapshot.data.length>0 ? snapshot.data!.last.postId :0;
                if (snapshot.connectionState == ConnectionState.done) {
                  if ((item?.length == 0 || item == null) && snapshot.data!.length>0) {
                    item = snapshot.data!
                        .map<MyListCard>((e) => MyListCard(
                      time: e.postTime,
                      message: e.contents,
                      backimg: e.backgroundPicUri,
                      postId: e.postId,
                      font: e.font,
                      fontColor: e.fontColor,
                      fontSize: e.fontSize,
                      fontBold: e.fontBold,
                    ))
                        .toList();
                  } else {
                    if (checknumber != lastnumber) {
                      item!.addAll(snapshot.data!
                          .map<MyListCard>((e) => MyListCard(
                        time: e.postTime,
                        message: e.contents,
                        backimg: e.backgroundPicUri,
                        postId: e.postId,
                        font: e.font,
                        fontColor: e.fontColor,
                        fontSize: e.fontSize,
                        fontBold: e.fontBold,
                      ))
                          .toList());
                    }
                  }
                }

                return Container(
                  decoration: gradient,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: SafeArea(
                        child: Stack(children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  IconButton(onPressed: (){
                                    Navigator.pop(context);
                                  }, icon:Icon(Icons.arrow_back_ios)),
                                  Expanded(child:
                                  Text("#내가 쓴 글", style: TextStyle(fontSize: 30.sp)),)
                                ],
                              ),
                              SizedBox(height: 10.h),
                              Expanded(
                                child:  SmartRefresher(
                                    enablePullDown: true,
                                    enablePullUp: true,
                                    header: CustomHeader(
                                      builder: (BuildContext context,
                                          RefreshStatus? mode) {
                                        Widget body;
                                        if (mode == RefreshStatus.refreshing)
                                          body = CupertinoActivityIndicator();
                                        else
                                          body = Text('');

                                        return Container(
                                          height: 55.0,
                                          child: Center(child: body),
                                        );
                                      },
                                    ),
                                    footer: CustomFooter(
                                      builder:
                                          (BuildContext context, LoadStatus) {
                                        return Container(
                                          height: 55.0,
                                          child: Center(child: Text("")),
                                        );
                                      },
                                    ),
                                    onRefresh: () async {
                                      setState(() {
                                        item!.clear();
                                        myfuture = GetAllPosts(
                                            0);
                                      });
                                      _refreshController.refreshCompleted();
                                    },
                                    // 새로고침
                                    onLoading: () async {
                                      if (lastnumber - 1 > 0) {
                                        setState(() {
                                          myfuture = GetAllPosts(lastnumber - 1);
                                          checknumber = lastnumber;
                                        });
                                        _refreshController.loadComplete();
                                      }
                                    },
                                    controller: _refreshController,
                                    child:
                                    ListView(
                                      controller: scrollController,
                                      children:
                                      item!.map<Widget>((e) => e).toList(),
                                    )),
                              )
                            ],
                          ),
                        ]),
                      ),
                    ),
                  ),
                );
              } else {
                return Container(
                    decoration: gradient,
                    child: Center(child: CircularProgressIndicator()));
              }
            }));
  }
}
