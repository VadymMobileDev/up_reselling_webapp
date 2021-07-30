import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:up_reselling_webapp/api/api_client.dart';
import 'package:up_reselling_webapp/models/data.dart';

class Repository {

  // FutureBuilder<ResponseData> _buildBody(BuildContext context) {
  //   final client = RestClient(Dio(BaseOptions(contentType: "application/json")),
  //       baseUrl: 'https://gorest.co.in/public-api/');
  //   return FutureBuilder<ResponseData>(
  //     future: client.getUsers(),
  //     builder: (context, snapshot) {
  //       print('snapshot.error ${snapshot.error}');
  //       if (snapshot.connectionState == ConnectionState.done) {
  //         final posts = snapshot.data;
  //         print(posts);
  //         if (posts != null) {
  //           return _buildPosts(context, posts);
  //         } else {
  //           return Center(
  //             child: Container(),
  //           );
  //         }
  //       } else {
  //         return Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       }
  //     },
  //   );
  // }
}
