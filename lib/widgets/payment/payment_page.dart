import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:up_reselling_webapp/application/app_color.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';
import 'package:up_reselling_webapp/bloc/domain_choose/bloc.dart';
import 'package:up_reselling_webapp/bloc/order_bloc/order_bloc.dart';
import 'package:up_reselling_webapp/bloc/send_order_number/send_order_bloc.dart';
import 'package:up_reselling_webapp/models/credit_card_model.dart';
import 'package:up_reselling_webapp/models/crypto_card_model.dart';
import 'package:up_reselling_webapp/models/domains_list.dart';
import 'package:up_reselling_webapp/repository/domain_repository.dart';
import '../widgets_repository.dart';
import 'check_and_pay_page.dart';
import 'credit_card_form.dart';
import 'credit_cardand_crypto_page.dart';
import 'crypto_card_form.dart';
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

  bool _flagCard = true;
  String cardNumber = '';
  String cryptoCardNumber = '';
  String expiryDate = '';
  String cvvCode = '';
  bool isCvvFocused = false;
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
        BlocProvider(
          create: (context) => SendOrderBloc(repository: DomainRepository()),
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset :false,
        body: Padding(
          padding: _spacePadding,
          child: Column(children: [
            BeckToHomeCloseWidget(),
            CardPaymentDataWidget(selectedDomainItems: widget.selectedDomainItems),

          Visibility(
              visible: true,

            child:EmailPaymentPage(),
          ),
          Visibility(
              visible: true,
            child: Column(
              children: [
                SizedBox(height: Dimens.paddingMedium),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() => _flagCard = !_flagCard);
                        },
                        child: Text("Pay with Credit Card",
                            style: TextStyle(
                                color: _flagCard ? AppColor.primaryBlue : AppColor.black,
                                fontSize: _flagCard
                                    ? Dimens.defaultFountSize
                                    : Dimens.paddingMedium,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() => _flagCard = !_flagCard);
                        },
                        child: Text("Pay with Crypto",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: _flagCard ? AppColor.black : AppColor.primaryBlue,
                                fontSize: _flagCard
                                    ? Dimens.paddingMedium
                                    : Dimens.defaultFountSize,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimens.paddingXSLarge),
                Column(
                  children: <Widget>[
                    if (_flagCard)
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: Text("Your Balance",
                                    style: TextStyle(
                                        color: AppColor.black, fontWeight: FontWeight.bold)),
                              ),
                            ),
                            CryptoCardForm(
                              formKey: formKey,
                              obscureNumber: true,
                              cryptoCardNumber: cryptoCardNumber,
                              themeColor: AppColor.primaryBlue,
                              cardNumberDecoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: '0.00000000',
                              ),
                              onCryptoCardModelChange: onCryptoCardModelChange,
                            ),
                          ],
                        ),
                      )
                    else
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: Text("Card Details",
                                    style: TextStyle(
                                        color: AppColor.black, fontWeight: FontWeight.bold)),
                              ),
                            ),
                            CreditCardForm(
                              formKey: formKey,
                              obscureCvv: true,
                              obscureNumber: true,
                              cardNumber: cardNumber,
                              cvvCode: cvvCode,
                              expiryDate: expiryDate,
                              themeColor: AppColor.primaryBlue,
                              cardNumberDecoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Card Number',
                              ),
                              expiryDateDecoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "MM/YY",
                              ),
                              cvvCodeDecoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "CVC",
                              ),
                              onCreditCardModelChange: onCreditCardModelChange,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                SizedBox(height: Dimens.paddingMedium),
                ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        print('valid!');
                      } else {
                        print('invalid!');
                      }
                    },
                    child: Text("Continue"),
                    style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        primary: AppColor.primaryBlue,
                        minimumSize: Size(double.infinity, Dimens.margeButtonEdge),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(Dimens.paddingDefault)))),
              ],
            )
          ),
            Visibility(
                visible: false,
                child: CheckAndPayPage()
            ),


            SpaceHeightWidget(),
            BottomTextPoweredWidget(),
          ]),
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  void onCryptoCardModelChange(CryptoCardModel? cryptoCardModel) {
    setState(() {
      cryptoCardNumber = cryptoCardModel!.cryptoCardNumber;
    });
  }
}

