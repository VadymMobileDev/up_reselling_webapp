import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:up_reselling_webapp/api/api_client.dart';
import 'package:up_reselling_webapp/models/domain_name.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      ),
      home: XummPage(),
    );
  }
}

class XummPage extends StatefulWidget {
  XummPage({Key? key}) : super(key: key);

  @override
  _XummPageState createState() => _XummPageState();
}

class _XummPageState extends State<XummPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [

            Text(
                'Purchase your\nBlockchain Domain',
                style: new TextStyle(
                    fontSize: 22.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                )
            ),
            Text(
                'Please enter at least 6 Characters'
            ),

            ElevatedButton(
                onPressed:(){

                }, child: Text("Check Domain")),
            Expanded(
              child: Container(
                height: 200,
                child: _buildBody(context),
              ),
            ),
            // _domainListName(context)
          ],
        )
    );
  }
}


FutureBuilder<DomainResponseData> _buildBody(BuildContext context) {
  final client = RestClient(Dio(BaseOptions(contentType: "application/json")));
  return FutureBuilder<DomainResponseData>(
    future: client.getDomainNameList("[\"crypto\"]"),
    builder: (context, snapshot) {

      if(snapshot.hasError){
      }
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
  return
    ListView.builder(
      itemCount: posts.crypto.length,
      itemBuilder: (context,index){
        return Card(
          child: ListTile(
            title: Text(" name : ${posts.crypto[index]['label']}")
          ),
        );
      },
    );
}