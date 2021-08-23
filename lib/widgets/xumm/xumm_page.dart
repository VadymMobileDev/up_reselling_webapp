import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';
import 'package:up_reselling_webapp/bloc/check_domain_bloc/check_domain_bloc.dart';
import 'package:up_reselling_webapp/repository/domain_repository.dart';
import 'package:up_reselling_webapp/widgets/check_domain_page.dart';
import 'package:up_reselling_webapp/widgets/widgets_repository.dart';

const _spacePadding = const EdgeInsets.only(
  top: Dimens.paddingMediumLarge,
  left: Dimens.paddingMedium,
  right: Dimens.paddingMedium,
  bottom: Dimens.paddingMediumLarge,
);

class XummPage extends StatefulWidget {
  XummPage({Key? key}) : super(key: key);

  @override
  _XummPageState createState() => _XummPageState();
}

class _XummPageState extends State<XummPage> {
  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => CheckDomainBloc(repository: DomainRepository()),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Padding(
            padding: _spacePadding,
            child: Column(
              children: [
                BeckToHomeOpenWidget(),
                CardUnstoppableWidget(),
                SizedBox(height: Dimens.paddingSemi),
                CardPurchaseWidget(),
                CheckDomainPage(enabled: true, nameEnabled: "", domainEnabled: ""),
                HelpCenterWidget(),
                SpaceHeightWidget(),
                BottomTextUnstoppableWidget()
              ],
            ),
          ),)
        ),
      );
}
