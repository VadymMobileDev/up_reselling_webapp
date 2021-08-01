import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:up_reselling_webapp/api/api_client.dart';
import 'package:up_reselling_webapp/application/app_color.dart';
import 'package:up_reselling_webapp/models/domain_name.dart';
import 'package:up_reselling_webapp/repository/repository_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  bool _flag = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
      children: [
        SizedBox(height: 16),
        Row(
          children: [
            Icon(Icons.ac_unit),
            ElevatedButton(onPressed: () {}, child: Text("Beck To Home"),
              style: ElevatedButton.styleFrom(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                ),),)
          ],
        ),
        SizedBox(height: 16),
        // _chooseDomainButtons(),

 Row(
                children:[
                  Expanded(child: ElevatedButton(onPressed: () {
                    setState(() => _flag = !_flag);
                  },child: Text("Register Domain"),
                      style: ElevatedButton.styleFrom(
                        primary: _flag ? AppColor.primaryBlue : AppColor.primaryGrey, // This is what you need!
                      )

                  )),
                  Expanded(child: ElevatedButton(onPressed: () {},child: Text("Manage Domain"))),
                ],
              ),

        SizedBox(height: 16),

        _unstoppableCard(),



        Text('Purchase your\nBlockchain Domain',
            style: TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.bold)),
        Text('Please enter at least 6 Characters'),
        Expanded(
          child: Container(
            height: 100,
            child: _buildBody(context),
          ),
        ),
        // Container(
        //         height: 200,
        //     child:

            Expanded(child: ElevatedButton(onPressed: () {

            },
                child: Text("Check Domain"),
                style: ElevatedButton.styleFrom(
                  primary: AppColor.primaryBlue
                )
             ),
          ),
        // _domainListName(context)
      ],
          ),
    ));
  }
}



Widget _unstoppableCard() {
  return Card(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("UNSTOPPABLE\nDOMAINS",
              style: new TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold)),
          Text('Replace cryptocurrency addresses with\na human readable name'),
        ],
      ),
    ),
  );
}


/*    Row(
    children: [
      ElevatedButton(onPressed: () {}, child: Text("Register Domain")),
      ElevatedButton(onPressed: () {}, child: Text("Manage Domain")),
    ],
  );*/
// }




FutureBuilder<DomainResponseData> _buildBody(BuildContext context) {
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
}

