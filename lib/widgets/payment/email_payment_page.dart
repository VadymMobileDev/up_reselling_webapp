import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:up_reselling_webapp/application/app_color.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';
import 'package:up_reselling_webapp/widgets/payment/payment_page.dart';

class EmailPaymentPage extends StatefulWidget {
  final bool showHidePay;
  final EmailCallback callback;

  EmailPaymentPage({Key? key, required this.callback, required this.showHidePay}) : super(key: key);

  @override
  EmailPaymentState createState() => EmailPaymentState();
}

class EmailPaymentState extends State<EmailPaymentPage> {
  TextEditingController domainController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: widget.showHidePay,
        child: Column(children: [
          Card(
            color: AppColor.backgroundLightGrey,
            elevation: 0.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(Dimens.paddingDefault)),
                side: BorderSide(width: 2, color: AppColor.borderCardGrey)),
            child: Padding(
              padding: EdgeInsets.all(Dimens.paddingSemi),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Form(
                              autovalidateMode: AutovalidateMode.always,
                              child: TextFormField(
                                validator: (value) => EmailValidator.validate(value!)
                                    ? null
                                    : "Please enter a valid email",
                                controller: domainController,
                                decoration: InputDecoration(
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  isDense: true,
                                  hintText: "Enter Email Address..",
                                ),
                                onFieldSubmitted: (_) async {
                                  widget.callback(domainController.text);
                                },
                              )))),
                ],
              ),
            ),
          ),
          SizedBox(height: Dimens.paddingSemi),
          Text(
            "This email address will be used to claim and manage your domain at: https://unstoppabledomains.com/api/v1\n/resellers/{resellerID}/domains",
            style: TextStyle(color: AppColor.textGrey),
          ),
          SizedBox(height: Dimens.paddingMedium),
        ]));
  }
}
