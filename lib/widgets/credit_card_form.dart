import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:up_reselling_webapp/application/app_color.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';
import 'package:up_reselling_webapp/models/credit_card_model.dart';
import 'package:up_reselling_webapp/repository/masked_card_contriller.dart';

class CreditCardForm extends StatefulWidget {
  const CreditCardForm({
    Key? key,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvvCode,
    this.obscureCvv = false,
    this.obscureNumber = false,
    required this.onCreditCardModelChange,
    required this.themeColor,
    this.textColor = AppColor.black,
    this.cursorColor,
    this.cardNumberDecoration = const InputDecoration(
      labelText: 'Card number',
      hintText: 'XXXX XXXX XXXX XXXX',
    ),
    this.expiryDateDecoration = const InputDecoration(
      labelText: 'Expired Date',
      hintText: 'MM/YY',
    ),
    this.cvvCodeDecoration = const InputDecoration(
      labelText: 'CVV',
      hintText: 'XXX',
    ),
    required this.formKey,
    this.cvvValidationMessage = 'Please input a valid CVV',
    this.dateValidationMessage = 'Please input a valid date',
    this.numberValidationMessage = 'Please input a valid number',
  }) : super(key: key);

  final String cardNumber;
  final String expiryDate;
  final String cvvCode;
  final String cvvValidationMessage;
  final String dateValidationMessage;
  final String numberValidationMessage;
  final void Function(CreditCardModel) onCreditCardModelChange;
  final Color themeColor;
  final Color textColor;
  final Color? cursorColor;
  final bool obscureCvv;
  final bool obscureNumber;
  final GlobalKey<FormState> formKey;

  final InputDecoration cardNumberDecoration;
  final InputDecoration expiryDateDecoration;
  final InputDecoration cvvCodeDecoration;

  @override
  _CreditCardFormState createState() => _CreditCardFormState();
}

class _CreditCardFormState extends State<CreditCardForm> {
  late String cardNumber;
  late String expiryDate;
  late String cardHolderName;
  late String cvvCode;
  bool isCvvFocused = false;
  late Color themeColor;

  late void Function(CreditCardModel) onCreditCardModelChange;
  late CreditCardModel creditCardModel;

  final MaskedTextController _cardNumberController =
      MaskedTextController(mask: '0000 0000 0000 0000');
  final TextEditingController _expiryDateController = MaskedTextController(mask: '00/00');
  final TextEditingController _cvvCodeController = MaskedTextController(mask: '000');

  FocusNode cvvFocusNode = FocusNode();
  FocusNode cardNumberNode = FocusNode();
  FocusNode expiryDateNode = FocusNode();

  void textFieldFocusDidChange() {
    creditCardModel.isCvvFocused = cvvFocusNode.hasFocus;
    onCreditCardModelChange(creditCardModel);
  }

  void createCreditCardModel() {
    cardNumber = widget.cardNumber;
    expiryDate = widget.expiryDate;
    cvvCode = widget.cvvCode;

    creditCardModel = CreditCardModel(cardNumber, expiryDate, cvvCode, isCvvFocused);
  }

  @override
  void initState() {
    super.initState();

    createCreditCardModel();

    onCreditCardModelChange = widget.onCreditCardModelChange;

    cvvFocusNode.addListener(textFieldFocusDidChange);

    _cardNumberController.addListener(() {
      setState(() {
        cardNumber = _cardNumberController.text;
        creditCardModel.cardNumber = cardNumber;
        onCreditCardModelChange(creditCardModel);
      });
    });

    _expiryDateController.addListener(() {
      setState(() {
        expiryDate = _expiryDateController.text;
        creditCardModel.expiryDate = expiryDate;
        onCreditCardModelChange(creditCardModel);
      });
    });

    _cvvCodeController.addListener(() {
      setState(() {
        cvvCode = _cvvCodeController.text;
        creditCardModel.cvvCode = cvvCode;
        onCreditCardModelChange(creditCardModel);
      });
    });
  }

  @override
  void dispose() {
    cvvFocusNode.dispose();
    expiryDateNode.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    themeColor = widget.themeColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: themeColor.withOpacity(0.8),
        primaryColorDark: themeColor,
      ),
      child: Form(
        key: widget.formKey,
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              margin: const EdgeInsets.only(
                  top: Dimens.paddingSmall),
              child: TextFormField(
                obscureText: widget.obscureNumber,
                controller: _cardNumberController,
                cursorColor: widget.cursorColor ?? themeColor,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(expiryDateNode);
                },
                style: TextStyle(
                  color: widget.textColor,
                ),
                decoration: widget.cardNumberDecoration,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                validator: (String? value) {
                  if (value!.isEmpty || value.length < 16) {
                    return widget.numberValidationMessage;
                  }
                  return null;
                },
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    margin: const EdgeInsets.only(
                        top: Dimens.paddingDefault,
                        right: Dimens.paddingMedium),
                    child: TextFormField(
                      controller: _expiryDateController,
                      cursorColor: widget.cursorColor ?? themeColor,
                      focusNode: expiryDateNode,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(cvvFocusNode);
                      },
                      style: TextStyle(
                        color: widget.textColor,
                      ),
                      decoration: widget.expiryDateDecoration,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return widget.dateValidationMessage;
                        }

                        final DateTime now = DateTime.now();
                        final List<String> date = value.split(RegExp(r'/'));
                        final int month = int.parse(date.first);
                        final int year = int.parse('20${date.last}');
                        final DateTime cardDate = DateTime(year, month);

                        if (cardDate.isBefore(now) || month > 12 || month == 0) {
                          return widget.dateValidationMessage;
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    margin: const EdgeInsets.only(left: Dimens.paddingMedium, top: Dimens.paddingDefault),
                    child: TextFormField(
                      obscureText: widget.obscureCvv,
                      focusNode: cvvFocusNode,
                      controller: _cvvCodeController,
                      cursorColor: widget.cursorColor ?? themeColor,
                      style: TextStyle(
                        color: widget.textColor,
                      ),
                      decoration: widget.cvvCodeDecoration,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      onChanged: (String text) {
                        setState(() {
                          cvvCode = text;
                        });
                      },
                      validator: (String? value) {
                        if (value!.isEmpty || value.length < 3) {
                          return widget.cvvValidationMessage;
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
