import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:up_reselling_webapp/application/app_color.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';
import 'package:up_reselling_webapp/bloc/send_order_number/bloc.dart';
import 'package:up_reselling_webapp/bloc/send_order_number/send_order_bloc.dart';

class EmailPaymentPage extends StatefulWidget {
  final bool showHidePay;

  EmailPaymentPage({Key? key,required this.showHidePay}) : super(key: key);

  @override
  EmailPaymentState createState() => EmailPaymentState();
}

class EmailPaymentState extends State<EmailPaymentPage> {
  TextEditingController domainController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    context.read<SendOrderBloc>().add(LoadSendOrder("","vadym.crypto"));
    return Visibility(
  visible: widget.showHidePay,
  child: Column(children: [
        BlocBuilder<SendOrderBloc, SendOrderState>(builder: (_, state) {
      if (state is HasDataSendOrder) {
        print("-------- state post "  + state.result.order.orderNumber.toString());

       return Card(
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
                        child: TextField(
                          controller: domainController,
                          decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            isDense: true,
                            hintText: "Enter Email Address..",
                          ),
                        ))),
                Container(height: 20, width: 2, color: AppColor.borderCardGrey),

              ],
            ),
          ),
        );

    } else {
        print("-------- state else");

        return CircularProgressIndicator();
    }}),

        SizedBox(height: Dimens.paddingSemi),
        Text("This email address will be used to claim and manage your domain at: https://unstoppabledomains.com/api/v1\n/resellers/{resellerID}/domains",
        style: TextStyle(color: AppColor.textGrey),),
        SizedBox(height: Dimens.paddingMedium),
      ]));
  }
}