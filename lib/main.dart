import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:up_reselling_webapp/application/app_color.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';
import 'package:up_reselling_webapp/widgets/check_domain_page.dart';
import 'package:up_reselling_webapp/widgets/payment/credit_cardand_crypto_page.dart';
import 'package:up_reselling_webapp/widgets/grid_list_domain_page.dart';
import 'package:up_reselling_webapp/widgets/register_manage_domain_page.dart';
import 'package:up_reselling_webapp/widgets/widgets_repository.dart';

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

class XummPage extends StatefulWidget {
  XummPage({Key? key}) : super(key: key);

  @override
  _XummPageState createState() => _XummPageState();
}

class _XummPageState extends State<XummPage> {
  var top = 0.0;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: AppColor.backgroundLightGrey,
            elevation: 0.0,
            pinned: true,
            floating: false,
            expandedHeight: 320.0,
            flexibleSpace:
                LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
              top = constraints.biggest.height;
              return FlexibleSpaceBar(
                title: Padding(
                    padding: EdgeInsets.only(
                      right: Dimens.paddingMediumLarge,
                      top: Dimens.paddingMediumLarge,
                    ),
                    child: top < 100 ? BeckToHomeCloseWidget() : null),
                background: Padding(
                  padding: EdgeInsets.only(
                    left: Dimens.paddingMediumLarge,
                    right: Dimens.paddingMediumLarge,
                    bottom: Dimens.paddingMediumLarge,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: Dimens.paddingMedium),
                      BeckToHomeOpenWidget(),
                      RegisterManageDomainPage(),
                      CardUnstoppableWidget(),
                    ],
                  ),
                ),
              );
            }),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: Dimens.paddingMediumLarge,
                    right: Dimens.paddingMediumLarge,
                    bottom: Dimens.paddingMediumLarge,
                  ),
                  child: Column(
                    children: [
                      CardPurchaseWidget(),
                      CheckDomainPage(),
                      TitleExtensionsWidget(domainName: "xummwallet"),
                      GridListDomainPage(),
                      HelpCenterWidget(),
                      CreditCardAndCryptoPage()
                    ],
                  ),
                );
              },
              childCount: 1,
            ),
          )
        ],
      ),
    );
  }
}


/*
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
*/
