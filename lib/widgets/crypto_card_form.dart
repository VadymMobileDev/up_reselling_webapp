import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:up_reselling_webapp/application/app_color.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';
import 'package:up_reselling_webapp/models/crypto_card_model.dart';
import 'package:up_reselling_webapp/repository/masked_card_contriller.dart';

class CryptoCardForm extends StatefulWidget {
  const CryptoCardForm({
    Key? key,
    required this.cryptoCardNumber,
    this.obscureNumber = false,
    required this.onCryptoCardModelChange,
    required this.themeColor,
    this.textColor = AppColor.black,
    this.cursorColor,
    this.cardNumberDecoration = const InputDecoration(
      labelText: 'Card number',
      hintText: 'X.XXXXXXXX',
    ),
    required this.formKey,
    this.numberValidationMessage = 'Please input a valid number',
  }) : super(key: key);

  final String cryptoCardNumber;
  final String numberValidationMessage;
  final void Function(CryptoCardModel) onCryptoCardModelChange;
  final Color themeColor;
  final Color textColor;
  final Color? cursorColor;
  final bool obscureNumber;
  final GlobalKey<FormState> formKey;

  final InputDecoration cardNumberDecoration;

  @override
  _CryptoCardFormState createState() => _CryptoCardFormState();
}

class _CryptoCardFormState extends State<CryptoCardForm> {
  late String cryptoCardNumber;
  late Color themeColor;

  late void Function(CryptoCardModel) onCryptoCardModelChange;
  late CryptoCardModel cryptoCardModel;

  FocusNode cardNumberNode = FocusNode();

  final MaskedTextController _cardNumberController = MaskedTextController(mask: '0.00000000');

  void createCryptoCardModel() {
    cryptoCardNumber = widget.cryptoCardNumber;

    cryptoCardModel = CryptoCardModel(cryptoCardNumber);
  }

  @override
  void initState() {
    super.initState();

    createCryptoCardModel();

    onCryptoCardModelChange = widget.onCryptoCardModelChange;

    _cardNumberController.addListener(() {
      setState(() {
        cryptoCardNumber = _cardNumberController.text;
        cryptoCardModel.cryptoCardNumber = cryptoCardNumber;
        onCryptoCardModelChange(cryptoCardModel);
      });
    });
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
              margin: const EdgeInsets.only(top: Dimens.paddingSmall),
              child: TextFormField(
                obscureText: widget.obscureNumber,
                controller: _cardNumberController,
                cursorColor: widget.cursorColor ?? themeColor,
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
          ],
        ),
      ),
    );
  }
}
