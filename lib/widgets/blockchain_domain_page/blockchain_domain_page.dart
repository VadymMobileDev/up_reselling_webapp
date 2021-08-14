import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';
import 'package:up_reselling_webapp/bloc/check_domain_bloc/check_domain_bloc.dart';
import 'package:up_reselling_webapp/bloc/domain_choose/bloc.dart';
import 'package:up_reselling_webapp/repository/domain_repository.dart';
import 'package:up_reselling_webapp/widgets/grid_list/grid_list_domain_page.dart';

import '../check_domain_page.dart';
import '../widgets_repository.dart';

const _spacePadding = const EdgeInsets.only(
  top: Dimens.paddingLarge,
  left: Dimens.paddingMediumLarge,
  right: Dimens.paddingMediumLarge,
  bottom: Dimens.paddingMediumLarge,
);

class BlockchainDomainPage extends StatefulWidget {
  final String domainName;
  final String domainLogo;
  final int? resellingPrice;


  BlockchainDomainPage({
    Key? key,
    required this.domainName,
    required this.domainLogo,
    required this.resellingPrice,
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
          create: (context) => CheckDomainBloc(repository: DomainRepository()),
        ),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: _spacePadding,
            child: Column(children: [
              BeckToHomeCloseWidget(),
              CardPurchaseWidget(),
              CheckDomainPage(enabled: false, nameEnabled: widget.domainName, domainEnabled: widget.domainLogo),
              TitleExtensionsWidget(domainName: widget.domainName),
              GridListDomainPage(
                domainsLogoSelected: widget.domainName + widget.domainLogo, resellingPrice: widget.resellingPrice
              )
            ]),
          ),
        ),
      ),
    );
  }
}
