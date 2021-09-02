import 'package:flutter/material.dart';
import 'package:up_reselling_webapp/application/app_color.dart';
import 'package:up_reselling_webapp/application/app_text.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';
import 'package:up_reselling_webapp/widgets/more_about_program/more_about_program_page.dart';
import 'package:up_reselling_webapp/widgets/xumm/xumm_page.dart';

import '../general/widgets_repository.dart';

class SuccessPayWidget extends StatelessWidget {
  final bool showSuccessPay;
  final String email;
  final int orderPrice;

  const SuccessPayWidget({Key? key, required this.showSuccessPay, required this.email, required this.orderPrice})
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
                child: Column(
                  children: <Widget>[
                    FittedBox(
                      child: Image.asset("assets/purchase.png"),
                      fit: BoxFit.fill,
                    ),
                    Padding(
                        padding: const EdgeInsets.all(Dimens.paddingMedium),
                        child: Column(
                          children: [
                            TextBold(
                                text: AppText.success_order,
                                fontSize: Dimens.paddingXSLarge,
                                color: AppColor.black),
                            SizedBox(height: Dimens.paddingMedium),
                            Text(AppText.success_emailed,
                                style: TextStyle(color: AppColor.textGrey)),
                            SizedBox(height: Dimens.paddingSemi),
                            Text("$email",
                                style:
                                    TextStyle(color: AppColor.black, fontWeight: FontWeight.bold)),
                            SizedBox(height: Dimens.paddingSemi),
                            Text("View Receipt",
                                style: TextStyle(
                                    color: AppColor.textBlue, fontWeight: FontWeight.bold)),
                            SizedBox(height: Dimens.paddingMedium),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Text("Order Total: ",
                                              style: TextStyle(color: AppColor.black)),
                                          Text(" \$$orderPrice",
                                              style: TextStyle(
                                                  color: AppColor.primaryBlue,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ],
                ),
              )),
          SizedBox(height: Dimens.paddingMedium),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => MoreAboutProgramingPage()),
                    (route) => false);
              },
              child: Text(AppText.success_join),
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
              AppText.success_search,
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
