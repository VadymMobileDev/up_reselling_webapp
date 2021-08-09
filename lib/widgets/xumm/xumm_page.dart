import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:up_reselling_webapp/application/app_color.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';
import 'package:up_reselling_webapp/bloc/domain_choose/bloc.dart';
import 'package:up_reselling_webapp/bloc/order_bloc/bloc.dart';
import 'package:up_reselling_webapp/repository/games_repository.dart';
import 'package:up_reselling_webapp/widgets/check_domain_page.dart';
import 'package:up_reselling_webapp/widgets/payment/credit_cardand_crypto_page.dart';
import 'package:up_reselling_webapp/widgets/grid_list/grid_list_domain_page.dart';
import 'package:up_reselling_webapp/widgets/register_manage_domain_page.dart';
import 'package:up_reselling_webapp/widgets/widgets_repository.dart';

const _spacePadding = const EdgeInsets.only(
  left: Dimens.paddingMediumLarge,
  right: Dimens.paddingMediumLarge,
  bottom: Dimens.paddingMediumLarge,
);

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
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DomainChooseBloc(repository: DomainRepository()),
          ),
          BlocProvider(
            create: (context) => OrderBloc(repository: DomainRepository()),
          ),
        ],
        child: Scaffold(
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
                      padding: _spacePadding,
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
                      padding: _spacePadding,
                      child: Column(
                        children: [
                          CardPurchaseWidget(),
                          CheckDomainPage(),
                          TitleExtensionsWidget(domainName: "xummwallet"),
                          GridListDomainPage(),
                          HelpCenterWidget(),
                          HomeScreen(),
                          HomeScreen2(),
                          CreditCardAndCryptoPage(),
                          Container(
                            height: 100,
                            //child: _buildBody(context),
                          )
                        ],
                      ),
                    );
                  },
                  childCount: 1,
                ),
              )
            ],
          ),
        ));
  }
}
