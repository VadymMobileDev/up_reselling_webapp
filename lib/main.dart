import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:up_reselling_webapp/api/api_client.dart';
import 'package:up_reselling_webapp/application/app_color.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';
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
        body: Padding(
      padding: EdgeInsets.all(Dimens.paddingMedium),
      child: Column(
        children: [
          SizedBox(height: Dimens.paddingMedium),
          _backToHome(),
          SizedBox(height: Dimens.paddingMedium),
          // _chooseDomainButtons(),

          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() => _flag = !_flag);
                      },
                      child: Text("Register Domain"),
                      style: ElevatedButton.styleFrom(
                        primary: _flag
                            ? AppColor.primaryBlue
                            : AppColor.primaryGrey, // This is what you need!
                      ))),
              Expanded(child: ElevatedButton(onPressed: () {}, child: Text("Manage Domain"))),
            ],
          ),

          SizedBox(height: Dimens.paddingMedium),
          _unstoppableCard(),
          _purchaseCard(),

/*        Expanded(
          child: Container(
            height: 100,
            child: _buildBody(context),
          ),
        ),*/
          ElevatedButton(
              onPressed: () {},
              child: Text("Check Domain"),
              style: ElevatedButton.styleFrom(
                  primary: AppColor.primaryBlue, minimumSize: Size(double.infinity, 60))),

          _textHelpCenter(),
          // _domainListName(context)
        ],
      ),
    ));
  }
}

Widget _backToHome() {
  return Row(
    children: [
      Icon(Icons.ac_unit),
      ElevatedButton.icon(
        icon: Icon(Icons.arrow_back_ios, color: AppColor.black, size: Dimens.paddingMedium),
        onPressed: () {},
        label: Text("Beck To Home", style: TextStyle(color: AppColor.black),),
        style: ElevatedButton.styleFrom(
        primary: AppColor.primaryGrey,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(Dimens.borderButtonRadius),
          ),
        ),
      )
    ],
  );
}



Widget _unstoppableCard() {
  return Card(
    color: AppColor.backgroundLightBlue,
    child: Padding(
      padding: EdgeInsets.all(Dimens.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("UNSTOPPABLE\nDOMAINS",
              style: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold)),
          SizedBox(height: Dimens.paddingSemi),
          Text('Replace cryptocurrency addresses with\na human readable name',
              style: TextStyle(fontSize: 14.0, color: AppColor.textGreyDark)),
        ],
      ),
    ),
  );
}

Widget _purchaseCard() {
  return Card(
    color: AppColor.backgroundLightGrey,
    elevation: 0.0,
    child: Padding(
      padding: EdgeInsets.only(top: Dimens.paddingMedium, bottom: Dimens.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("Purchase your\nBlockchain Domain",
              style: TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.bold)),
          SizedBox(height: Dimens.paddingSemi),
          Text("Please enter at least 6 Characters", style: TextStyle(color: AppColor.textGrey)),
        ],
      ),
    ),
  );
}

Widget _textHelpCenter(){
  return Expanded(
    child: Align(
      alignment: Alignment.bottomCenter,
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
                text: "Have any issues? ", style: TextStyle(color: AppColor.textGreyDark)),
            TextSpan(
                text: "Help Center",
                style: TextStyle(color: AppColor.textBlue, fontWeight: FontWeight.bold)),
          ],
        ),
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
