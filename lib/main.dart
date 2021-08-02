import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:up_reselling_webapp/api/api_client.dart';
import 'package:up_reselling_webapp/application/app_color.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';
import 'package:up_reselling_webapp/models/domain_name.dart';

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

      body:SingleChildScrollView(
          child: Padding(
      padding: EdgeInsets.all(Dimens.paddingMediumLarge),
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
                      child: Text("Register Domain",
                          style: TextStyle(color: _flag ? AppColor.white : AppColor.textGrey)),
                      style: ElevatedButton.styleFrom(
                        primary: _flag ? AppColor.primaryBlue : AppColor.primaryGrey, minimumSize: Size(double.infinity, Dimens.margeButtonsEdge),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(Dimens.paddingDefault),
                          )
                      ))),
              Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() => _flag = !_flag);
                      },
                      child: Text("Manage Domain",
                          style: TextStyle(color: _flag ? AppColor.textGrey : AppColor.white)),
                      style: ElevatedButton.styleFrom(
                        primary: _flag ? AppColor.primaryGrey : AppColor.primaryBlue, minimumSize: Size(double.infinity, Dimens.margeButtonsEdge),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(Dimens.paddingDefault),
                          )
                      ))),
            ],
          ),

          SizedBox(height: Dimens.paddingMedium),
          _unstoppableCard(),
          _purchaseCard(),

          Card(
            color: AppColor.backgroundLightGrey,
            elevation: 0.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(Dimens.paddingDefault)),
                side: BorderSide(width: 2, color: AppColor.borderCardGrey)),
            child: Padding(
              padding: EdgeInsets.all(Dimens.paddingSemi),
              child: Row(
                children: <Widget>[
              Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child:
                  Text("wwumwallet", style: TextStyle(color: AppColor.black, fontSize: Dimens.paddingMedium)),
              )),
               ElevatedButton(
                    onPressed: () {},
                    child:Row(
                      children:[
                        Container(
                          child: Text(".crypto", style: TextStyle(color: AppColor.black)),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(4, 0, 10, 0),
                          child: Icon(Icons.arrow_drop_down, color: AppColor.textGreyDark, size: Dimens.paddingMedium)
                          ),
                      ],
                    ),
                      style: ElevatedButton.styleFrom(
                      primary: AppColor.backgroundLightGrey, elevation: 0.0
                    ),
                  )

                ],
              ),
            ),
          ),


          SizedBox(height: Dimens.paddingMedium),
          _checkDomainButton(),
          SizedBox(height: Dimens.paddingMediumLarge),
          _textExtensions("xummwallet"),

            Container(
                width: MediaQuery.of(context).size.width,
                child:
          GridView.count(
            primary: false,
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              _listGridContainer(".x"),
              _listGridContainer(".crypto"),
              _listGridContainer(".coin"),
              _listGridContainer(".wallet"),
              _listGridContainer(".bitcoin"),
              _listGridContainer(".888"),
              _listGridContainer(".nft"),
              _listGridContainer(".dao"),
              _listGridContainer(".zil"),
            ],
          ),
            ),

          _textHelpCenter(),
          // _domainListName(context)
        ],
      ),
    )));
  }
}

Widget _backToHome() {
  return Row(
    children: [
  Expanded(
     child: Align(
    alignment: Alignment.centerLeft,
    child:   Icon(Icons.ac_unit),
    ),),
  Expanded(
    child: Align(
        alignment: Alignment.centerRight,
        child:       ElevatedButton.icon(
          icon: Icon(Icons.arrow_back_ios, color: AppColor.black, size: Dimens.paddingMedium),
          onPressed: () {},
          label: Text("Beck To Home", style: TextStyle(color: AppColor.black),),
          style: ElevatedButton.styleFrom(
            primary: AppColor.primaryGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimens.borderButtonRadius),
            ),
          ),
        )
      ),),

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

Widget _textExtensions(String name) {
  return Align(
      alignment: Alignment.centerLeft,
      child: Container(
          child: Text("Extensions for \"" + "$name" + "\"",
              style: TextStyle(color: AppColor.textBlue, fontWeight: FontWeight.bold))));
}

Widget _checkDomainButton(){
  return ElevatedButton(
      onPressed: () {},
      child: Text("Check Domain"),
      style: ElevatedButton.styleFrom(
          primary: AppColor.primaryBlue,
          minimumSize: Size(double.infinity, Dimens.margeButtonEdge),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimens.paddingDefault))));
}

Widget _textHelpCenter(){
  return RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
                text: "Have any issues? ", style: TextStyle(color: AppColor.textGreyDark)),
            TextSpan(
                text: "Help Center",
                style: TextStyle(color: AppColor.textBlue, fontWeight: FontWeight.bold)),
          ],
        ),
  );
}


Widget _listGridContainer(String text){
  return Container(
      padding: const EdgeInsets.all(8),
      child: Text(text),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: AppColor.borderCardGrey)
      )
  );
}


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
