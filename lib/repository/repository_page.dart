import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:up_reselling_webapp/models/domain_name.dart';
import 'package:up_reselling_webapp/network/api/api_client.dart';

class Repository {

/*  FutureBuilder<DomainResponseData> buildBody(BuildContext context) {
    final client = RestClient(Dio(BaseOptions(contentType: "application/json")));
    return FutureBuilder<DomainResponseData>(
      future: client.getDomainNameList("[\"crypto\"]"),
      builder: (context, snapshot) {
        if (snapshot.hasError) {}
        if (snapshot.connectionState == ConnectionState.done) {
          final posts = snapshot.data;

          return _buildPosts(context, posts!);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildPosts(BuildContext context, DomainResponseData posts) {
    return ListView.builder(
      itemCount: posts.crypto.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(title: Text(" name : ${posts.crypto[index]['label']}")),
        );
      },
    );
  }*/

}
