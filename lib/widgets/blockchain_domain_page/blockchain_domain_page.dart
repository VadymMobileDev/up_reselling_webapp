import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:up_reselling_webapp/bloc/check_domain_bloc/check_domain_bloc.dart';
import 'package:up_reselling_webapp/bloc/domain_choose/bloc.dart';
import 'package:up_reselling_webapp/models/domain_check.dart';
import 'package:up_reselling_webapp/models/domains_list.dart';
import 'package:up_reselling_webapp/repository/domain_repository.dart';
import 'package:up_reselling_webapp/widgets/grid_list/grid_list_domain_page.dart';

import '../general/check_domain_page.dart';
import '../general/widgets_repository.dart';
import 'check_domain_page.dart';


class BlockchainDomainPage extends StatefulWidget {
  final Domain domain;

  BlockchainDomainPage({
    Key? key,
    required this.domain,
  }) : super(key: key);

  @override
  _BlockchainDomainPageState createState() => _BlockchainDomainPageState();
}

class _BlockchainDomainPageState extends State<BlockchainDomainPage> {
  List<DomainItemCart> selectedDomains = [];
  late Domain domainBlockchain;

  @override
  void initState() {
    super.initState();
    domainBlockchain = widget.domain;
  }

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
              BackToHomeCloseWidget(blockchain: true),
              CardPurchaseWidget(),
              CheckDomainPage(
                  enabled: false,
                  domain: domainBlockchain,
                  domainCallback: (domain) => setState(() => domainBlockchain = domain)
              ),
              TitleExtensionsWidget(domainName: "" + domainBlockchain.name!),
              GridListDomainPage(
                  domainsLogoSelected: domainBlockchain.name!,
                  resellingValidate: domainBlockchain.reselling == null ? false : true,

                  addSelectedDomainsCallback: (selectedDomainItemCarts) =>
                      setState(() => selectedDomains.add(selectedDomainItemCarts))),

              CheckoutDomainWidget(selectedDomainItemCarts: selectedDomains),
            ]),
          ),
        ),
      ),
    );
  }
}

typedef void ShowHideCheckCallback(bool val);
typedef void GetChooseDomainListCallback(DomainItemCart selectedDomainItemCarts);
typedef void CheckDomainCallback(Domain domain);
