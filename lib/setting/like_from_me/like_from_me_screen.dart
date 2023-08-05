import 'package:dorandoran/setting/write_from_me/component/my_list_card.dart';
import 'quest/get_all_liked_posts.dart';
import 'package:flutter/material.dart';
import 'package:dorandoran/common/css.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../common/basic.dart';


class LikeFromMeScreen extends StatefulWidget {

  const LikeFromMeScreen({
    Key? key}) : super(key: key);

  @override
  State<LikeFromMeScreen> createState() => _LikeFromMeScreenState();
}
class _LikeFromMeScreenState extends State<LikeFromMeScreen> {
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
    myfuture = GetAllLikedPosts(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("좋아요 한 글"),
    ),
    body: Container(
    color: backgroundcolor,
    child: SafeArea(
    top: true,
    bottom: true,
    child: FutureBuilder(
            future: myfuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if(snapshot.data!.length==0){
                  return Center(child:Text("좋아요 한 글이 없습니다."));
                }
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
                                        myfuture = GetAllLikedPosts(
                                            0);
                                      });
                                      _refreshController.refreshCompleted();
                                    },
                                    // 새로고침
                                    onLoading: () async {
                                      if (lastnumber - 1 > 0) {
                                        setState(() {
                                          myfuture = GetAllLikedPosts(lastnumber - 1);
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
            }))));
  }
}
