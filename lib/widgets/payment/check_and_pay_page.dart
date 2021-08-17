import 'package:flutter/material.dart';
import 'package:up_reselling_webapp/application/app_color.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';

class CheckAndPayPage extends StatefulWidget {
  final bool showHidePay;
  CheckAndPayPage({Key? key, required this.showHidePay}) : super(key: key);

  @override
  CheckAndPayPageState createState() => CheckAndPayPageState();
}

class CheckAndPayPageState extends State<CheckAndPayPage> {

  @override
  Widget build(BuildContext context) => Visibility(
  visible: widget.showHidePay,
  child: Column(children: [
        Text("You are about to pay"),
        Text(""),
        Text("for "),
        SizedBox(height: Dimens.paddingMedium),
        ElevatedButton(
            onPressed: () {
            },
            child: Text("Pay"),
            style: ElevatedButton.styleFrom(
                elevation: 0.0,
                primary: AppColor.primaryBlue,
                minimumSize: Size(double.infinity, Dimens.margeButtonEdge),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimens.paddingDefault)))),
        SizedBox(height: Dimens.paddingMediumLarge),
      ]));
}
