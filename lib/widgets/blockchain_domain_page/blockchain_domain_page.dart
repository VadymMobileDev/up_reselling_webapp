import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';
import 'package:up_reselling_webapp/bloc/check_domain_bloc/check_domain_bloc.dart';
import 'package:up_reselling_webapp/bloc/domain_choose/bloc.dart';
import 'package:up_reselling_webapp/repository/domain_repository.dart';
import 'package:up_reselling_webapp/widgets/grid_list/grid_list_domain_page.dart';

import '../general/check_domain_page.dart';
import '../general/widgets_repository.dart';

class BlockchainDomainPage extends StatefulWidget {
  final String domainName;
  final String domainLogo;
  final bool resellingValidate;
  final List<String> spinnerItems;

  BlockchainDomainPage({
    Key? key,
    required this.domainName,
    required this.domainLogo,
    required this.resellingValidate,
    required this.spinnerItems,
  }) : super(key: key);

  @override
  _BlockchainDomainPageState createState() => _BlockchainDomainPageState();
}

class _BlockchainDomainPageState extends State<BlockchainDomainPage> {

  bool showHideBlockchainDomain = true;

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
            padding: spacePadding,
            child: Column(children: [
              BackToHomeCloseWidget(),
              CardPurchaseWidget(),
              CheckDomainPage(
                  enabled: false, nameEnabled: widget.domainName, domainEnabled: widget.domainLogo),
              TitleExtensionsWidget(domainName: widget.domainName),
              GridListDomainPage(
                  domainsLogoSelected: widget.domainName + widget.domainLogo, spinnerItems: widget.spinnerItems,
                  resellingValidate: widget.resellingValidate, callback: (val) => setState(() => showHideBlockchainDomain = val))
            ]),
          ),
        ),
      ),
    );
  }
}

typedef void ShowHideCheckCallback(bool val);
