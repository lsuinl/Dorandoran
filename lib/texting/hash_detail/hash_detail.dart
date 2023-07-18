import 'package:flutter/material.dart';
import 'package:dorandoran/common/css.dart';
import 'package:dorandoran/texting/home/quest/home_getcontent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../common/basic.dart';
import '../home/component/home_message_card.dart';
import 'quest/hash_detail_getcontent.dart';

class HashDetail extends StatefulWidget {
  final String tagnames;

  const HashDetail({
    required this.tagnames,
    Key? key}) : super(key: key);

  @override
  State<HashDetail> createState() => _HashDetailState();
}
class _HashDetailState extends State<HashDetail> {
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  ScrollController scrollController = ScrollController();
  late Future myfuture;
  List<Message_Card>? item;
  int? checknumber;

  @override
  void initState() {
    super.initState();
    setState(() {
      _refreshController = RefreshController(initialRefresh: false);
      scrollController = ScrollController();
    });
    myfuture = getHashContent(widget.tagnames,0);
  }

  @override
  Widget build(BuildContext context) {
    return Basic(
        widgets: FutureBuilder(
            future: myfuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                int lastnumber = snapshot.data.length>0 ? snapshot.data!.last.postId :0;
                if (snapshot.connectionState == ConnectionState.done) {
                  if ((item?.length == 0 || item == null) && snapshot.data!.length>0) {
                    item = snapshot.data!
                        .map<Message_Card>((e) => Message_Card(
                      time: e.postTime,
                      heart: e.likeCnt,
                      chat: e.replyCnt,
                      map: e.location,
                      message: e.contents,
                      backimg: e.backgroundPicUri,
                      postId: e.postId,
                      likeresult: e.likeResult,
                      font: e.font,
                      fontColor: e.fontColor,
                      fontSize: e.fontSize,
                      fontBold: e.fontBold,
                    ))
                        .toList();
                  } else {
                    if (checknumber != lastnumber) {
                      item!.addAll(snapshot.data!
                          .map<Message_Card>((e) => Message_Card(
                        time: e.postTime,
                        heart: e.likeCnt,
                        chat: e.replyCnt,
                        map: e.location,
                        message: e.contents,
                        backimg: e.backgroundPicUri,
                        postId: e.postId,
                        likeresult: e.likeResult,
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
                                  Text("#${widget.tagnames}", style: TextStyle(fontSize: 30.sp)),)
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
                                        myfuture = getHashContent(
                                          widget.tagnames,
                                          0);
                                      });
                                      _refreshController.refreshCompleted();
                                    },
                                    // 새로고침
                                    onLoading: () async {
                                      if (lastnumber - 1 > 0) {
                                        setState(() {
                                          myfuture = getHashContent(
                                              widget.tagnames,
                                              lastnumber - 1);
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
