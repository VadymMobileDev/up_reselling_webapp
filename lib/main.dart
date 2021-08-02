import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:up_reselling_webapp/api/api_client.dart';
import 'package:up_reselling_webapp/application/app_color.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';
import 'package:up_reselling_webapp/models/credit_card_model.dart';
import 'package:up_reselling_webapp/models/domain_name.dart';
import 'package:up_reselling_webapp/repository/labeled_check_box.dart';
import 'package:up_reselling_webapp/widgets/credit_card_form.dart';
import 'package:up_reselling_webapp/widgets/widgets_repository.dart';

import 'models/grid_domain.dart';

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
  String cardNumber = '';
  String expiryDate = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:SingleChildScrollView(
          child: Padding(
      padding: EdgeInsets.all(Dimens.paddingMediumLarge),
      child: Column(
        children: [
          SizedBox(height: Dimens.paddingMedium),
          BeckToHomeWidget(),
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
          CardUnstoppableWidget(),
          CardPurchaseWidget(),

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
          TitleExtensionsWidget(domainName: "xummwallet"),

          _gridViewContainer(context),


/*          Container(
    width: MediaQuery.of(context).size.width,
    child:
          GridView.builder(
              itemCount: itemList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.56,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2),
              itemBuilder: (context, index) {
                return GridItem(
                    item: itemList[index],
                    isSelected: (bool value) {
                      setState(() {
                        if (value) {
                          selectedList.add(itemList[index]);
                        } else {
                          selectedList.remove(itemList[index]);
                        }
                      });
                      print("$index : $value");
                    },
                    key: Key(itemList[index].price));
              }),
          ),*/

          SizedBox(height: Dimens.paddingMedium),

          HelpCenterWidget(),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                  children:[
                    CreditCardForm(
                      formKey: formKey,
                      obscureCvv: true,
                      obscureNumber: true,
                      cardNumber: cardNumber,
                      cvvCode: cvvCode,
                      expiryDate: expiryDate,
                      themeColor: Colors.blue,
                      cardNumberDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Number',
                        hintText: 'XXXX XXXX XXXX XXXX',
                      ),
                      expiryDateDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Expired Date',
                        hintText: 'XX/XX',
                      ),
                      cvvCodeDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'CVV',
                        hintText: 'XXX',
                      ),
                      onCreditCardModelChange: onCreditCardModelChange,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        primary: const Color(0xff1b447b),
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        child: const Text(
                          'VALIDATE',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'halter',
                            fontSize: 14,
                            package: 'flutter_credit_card',
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          print('valid!');
                        } else {
                          print('invalid!');
                        }
                      },
                    )
                  ],
                ),
              ),
        ],
      ),

    )));
  }


  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

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

Widget _gridViewContainer(BuildContext context){
  return Container(
    width: MediaQuery.of(context).size.width,
    child:
    GridView.count(
      primary: false,
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[

        GridContainerBody(titleText: ".x", checkText: "100"),
        GridContainerBody(titleText: ".crypto", checkText: "40"),
        GridContainerBody(titleText: ".coin", checkText: "20"),
        GridContainerBody(titleText: ".wallet", checkText: "40"),
        GridContainerBody(titleText: ".bitcoin", checkText: "20"),
        GridContainerBody(titleText: ".888", checkText: "20"),
        GridContainerBody(titleText: ".nft", checkText: "20"),
        GridContainerBody(titleText: ".dao", checkText: "20"),
        GridContainerBody(titleText: ".zil", checkText: "20"),
      ],
    ),
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

