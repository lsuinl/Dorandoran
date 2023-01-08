import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
final TextStyle whitestyle = TextStyle(
  color: Colors.white,
  fontSize: 17.0,
  fontWeight: FontWeight.w500,
);

Color backgroundcolor=Color(0xFF000054);

final url=Uri.parse(
  'http://124.60.219.83:8080/api/signup'
);
