import 'package:dorandoran/common/quest_token.dart';
import 'package:dorandoran/setting/quest/get_all_posts.dart';
import 'package:dorandoran/setting/component/my_list_card.dart';
import 'my_list_top.dart';
import '../quest/get_all_liked_posts.dart';
import 'package:flutter/material.dart';
import 'package:dorandoran/common/css.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class MyListScreen extends StatefulWidget {
  final String text;

  const MyListScreen({
    required this.text,
    Key? key}) : super(key: key);

  @override
  State<MyListScreen> createState() => _MyListScreenState();
}
class _MyListScreenState extends State<MyListScreen> {
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
    if(widget.text=="좋아요 한 글")
      myfuture = GetAllLikedPosts(0);
    else
      myfuture=GetAllPosts(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Container(
    color: backgroundcolor,
    child: SafeArea(
    top: true,
    bottom: true,
    child: FutureBuilder(
            future: myfuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if(snapshot.data==401){
                  quest_token();
                  myfuture;
                }
                if(snapshot.data!.length==0){
                  return Column(
                      children: [
                        MyListTop(text: widget.text),
                        Flexible(child:
                        Center(child:Text("글이 없습니다.")))]);
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
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Stack(children: [
                          Column(
                            children: [
                              MyListTop(text: "좋아요 한 글",),
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
                                        myfuture =    widget.text=="좋아요 한 글"? GetAllLikedPosts(
                                            0): GetAllPosts(0);
                                      });
                                      _refreshController.refreshCompleted();
                                    },
                                    // 새로고침
                                    onLoading: () async {
                                      if (lastnumber - 1 > 0 && snapshot.data.length==20) {
                                        setState(() {
                                          myfuture =    widget.text=="좋아요 한 글"? GetAllLikedPosts(
                                              lastnumber - 1): GetAllPosts(lastnumber - 1);
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
                    ) ;
              } else {
                return Container(
                    decoration: gradient,
                    child: Center(child: CircularProgressIndicator()));
              }
            }))));
  }
}
