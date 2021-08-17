import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';
import 'package:up_reselling_webapp/bloc/domain_choose/bloc.dart';
import 'package:up_reselling_webapp/bloc/order_bloc/order_bloc.dart';
import 'package:up_reselling_webapp/bloc/send_order_number/send_order_bloc.dart';
import 'package:up_reselling_webapp/models/domains_list.dart';
import 'package:up_reselling_webapp/repository/domain_repository.dart';
import '../widgets_repository.dart';
import 'credit_cardand_crypto_page.dart';
import 'email_payment_page.dart';

const _spacePadding = const EdgeInsets.only(
  top: Dimens.paddingLarge,
  left: Dimens.paddingMediumLarge,
  right: Dimens.paddingMediumLarge,
  bottom: Dimens.paddingMediumLarge,
);

class PaymentPage extends StatefulWidget {
  final List<DomainItemCart> selectedDomainItems;

  PaymentPage({Key? key, required this.selectedDomainItems}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  TextEditingController domainController = TextEditingController();
  bool showHidePay = true;

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
        BlocProvider(
          create: (context) => SendOrderBloc(repository: DomainRepository()),
        ),
      ],
      child: Scaffold(
        body: Padding(
          padding: _spacePadding,
          child: Column(children: [
            BeckToHomeCloseWidget(),
            CardPaymentDataWidget(selectedDomainItems: widget.selectedDomainItems),
            EmailPaymentPage(showHidePay:showHidePay),
            CreditCardAndCryptoPage(),
            SpaceHeightWidget(),
            // CheckAndPayPage(showHidePay: showHidePay),
            BottomTextPoweredWidget(),
          ]),
        ),
      ),
    );
  }
}

