import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';
import 'package:up_reselling_webapp/bloc/domain_choose/bloc.dart';
import 'package:up_reselling_webapp/bloc/order_bloc/order_bloc.dart';
import 'package:up_reselling_webapp/models/domain_name.dart';
import 'package:up_reselling_webapp/repository/domain_repository.dart';
import 'package:up_reselling_webapp/widgets/grid_list/grid_list_domain_page.dart';

import '../check_domain_page.dart';
import '../widgets_repository.dart';

const _spacePadding = const EdgeInsets.only(
  top: Dimens.paddingLarge,
  left: Dimens.paddingMediumLarge,
  right: Dimens.paddingMediumLarge,
);

class BlockchainDomainPage extends StatefulWidget {
  final String domainName;
  final String domainLogo;

  final List domainsList;

  BlockchainDomainPage({
    Key? key,
    required this.domainName,
    required this.domainLogo,
    required this.domainsList,
  }) : super(key: key);

  @override
  _BlockchainDomainPageState createState() => _BlockchainDomainPageState();
}

class _BlockchainDomainPageState extends State<BlockchainDomainPage> {
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
        body: SingleChildScrollView(
          child: Padding(
            padding: _spacePadding,
            child: Column(children: [
              BeckToHomeCloseWidget(),
              CardPurchaseWidget(),
              CheckDomainPage(enabled: false),
              AddToCartWidget(),
              TitleExtensionsWidget(domainName: widget.domainName),
              GridListDomainPage(
                domainsGridList: widget.domainsList,
              )
            ]),
          ),
        ),
      ),
    );
  }
}
