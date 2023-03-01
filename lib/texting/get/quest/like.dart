//글 공감
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:io';
import '../model/postcard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';

//글 가져오기
void postLike(
    int postId, String email) async {
  var response = await http.post(
    Uri.parse('$url/api/post-like'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      "email":email,
      "postId": postId,
    }),
  );
}


// uri : api/post-like
// ex) {"postId" : 1, "email" : "safjdk@naver.com"}
// Long postId
// String email