import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:up_reselling_webapp/widgets/xumm/xumm_page.dart';
import 'models/domain_name.dart';
import 'network/api/api_client.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: XummPage(),
    );
  }
}
