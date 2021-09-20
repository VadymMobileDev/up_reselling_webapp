import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:up_reselling_webapp/application/app_color.dart';
import 'package:up_reselling_webapp/bloc/domain_choose/bloc.dart';
import 'package:up_reselling_webapp/bloc/order_bloc/order_bloc.dart';
import 'package:up_reselling_webapp/bloc/send_order_number/send_order_bloc.dart';
import 'package:up_reselling_webapp/models/domains_list.dart';
import 'package:up_reselling_webapp/repository/domain_repository.dart';
import 'package:up_reselling_webapp/widgets/payment/success_pay_form.dart';

import '../general/widgets_repository.dart';
import 'check_and_pay_page.dart';
import 'credit_cardand_crypto_page.dart';
import 'email_payment_page.dart';

class PaymentPage extends StatefulWidget {
  final List<DomainItemCart> selectedDomainItems;
  final double currencyDomain;

  PaymentPage({Key? key, required this.selectedDomainItems, required this.currencyDomain}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  TextEditingController domainController = TextEditingController();
  bool showHidePay = true;
  bool successPay = false;
  String email = "nischal@unstoppabledomains.com";
  int price = 0;

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
        backgroundColor: AppColor.white,
        body: SingleChildScrollView(
        child: Padding(
          padding: spacePadding,
          child: Column(children: [
            BackToHomeCloseWidget(blockchain: false),
            Visibility(
                visible: !successPay,
                child: Column(
              children: [
                CardPaymentDataWidget(selectedDomainItems: widget.selectedDomainItems, currencyDomain: widget.currencyDomain),
                EmailPaymentPage(callback: (v) => setState(() => email = v), showHidePay: showHidePay),
                CreditCardAndCryptoPage(
                    callback: (val) => setState(() => showHidePay = val), showHidePay: showHidePay),
                CheckAndPayPage(callbackSuccessPay: (val, orderPrice) {
                  setState(() => successPay = val);
                  setState(() => price = orderPrice);
                },
                    selectedDomainItems: widget.selectedDomainItems, showHidePay: showHidePay, userEmail: email),
              ],
            )),
            SuccessPayWidget(showSuccessPay: successPay, email: email, orderPrice: price),
            SpaceHeightWidget(),
            BottomTextPoweredWidget(),
          ]),
        ),
      ),
      ),
    );
  }
}

typedef void ShowHidePayCallback(bool val);
typedef void EmailCallback(String v);
typedef void ShowSuccessPayCallback(bool v, int orderPrice);
