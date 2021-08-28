import 'package:flutter/material.dart';
import 'package:up_reselling_webapp/application/app_color.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';
import 'package:up_reselling_webapp/widgets/more_about_program/more_about_program_page.dart';
import 'package:up_reselling_webapp/widgets/xumm/xumm_page.dart';

class SuccessPayWidget extends StatelessWidget {
  final bool showSuccessPay;
  final String email;

  const SuccessPayWidget({Key? key, required this.showSuccessPay, required this.email})
      : super(key: key);

  Widget build(BuildContext context) => Visibility(
      visible: showSuccessPay,
      child: Column(
        children: [
          Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: AppColor.textGreyMiddle, width: 0.5),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                  child: MergeSemantics(
                      child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Text("Thank you four your order!",
                        style: TextStyle(
                            fontSize: Dimens.paddingXSLarge,
                            color: AppColor.black,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: Dimens.paddingMedium),
                    Text("We've emailed your receipt to",
                        style: TextStyle(color: AppColor.textGrey)),
                    SizedBox(height: Dimens.paddingSemi),
                    Text("$email",
                        style: TextStyle(color: AppColor.black, fontWeight: FontWeight.bold)),
                    SizedBox(height: Dimens.paddingSemi),
                    Text("View Receipt",
                        style: TextStyle(color: AppColor.textBlue, fontWeight: FontWeight.bold)),
                    SizedBox(height: Dimens.paddingMedium),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  Text("Order Total: ", style: TextStyle(color: AppColor.black)),
                                  Text(" \$${40}",
                                      style: TextStyle(
                                          color: AppColor.primaryBlue,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text(" Details ", style: TextStyle(color: AppColor.primaryBlue)),
                          style: ElevatedButton.styleFrom(
                              elevation: 0.0,
                              primary: AppColor.backgroundLightBlue,
                              minimumSize: Size(double.minPositive, Dimens.iconHeight),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(Dimens.paddingDefault))),
                        ),
                      ],
                    ),
                  ],
                ),
              )))),
          SizedBox(height: Dimens.paddingMedium),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => MoreAboutProgramingPage()),
                    (route) => false);
              },
              child: Text("Join our Referral Program"),
              style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  primary: AppColor.primaryBlue,
                  minimumSize: Size(double.infinity, Dimens.margeButtonEdge),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimens.paddingDefault)))),
          SizedBox(height: Dimens.paddingMedium),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => XummPage()), (route) => false);
            },
            child: Text(
              "Search for a New Domain",
              style: TextStyle(
                color: AppColor.primaryBlue,
              ),
            ),
            style: OutlinedButton.styleFrom(
              minimumSize: Size(double.infinity, Dimens.margeButtonEdge),
              shape:
                  BeveledRectangleBorder(borderRadius: BorderRadius.circular(Dimens.paddingSmall)),
            ),
          ),
        ],
      ));
}
