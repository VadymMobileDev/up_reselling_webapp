import 'package:flutter/material.dart';
import 'package:up_reselling_webapp/application/app_color.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';

const _spacePadding = const EdgeInsets.only(
  top: Dimens.paddingMediumLarge,
  left: Dimens.paddingMedium,
  right: Dimens.paddingMedium,
  bottom: Dimens.paddingMediumLarge,
);

class MoreAboutProgramingPage extends StatefulWidget {
  MoreAboutProgramingPage({Key? key}) : super(key: key);

  @override
  _MoreAboutProgramingState createState() => _MoreAboutProgramingState();
}

class _MoreAboutProgramingState extends State<MoreAboutProgramingPage> {

  TextEditingController domainController = TextEditingController();

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        body: Padding(
              padding: _spacePadding,
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
                                    Text("View Receipt",
                                        style: TextStyle(
                                            color: AppColor.textBlue, fontWeight: FontWeight.bold)),
                                    Text("We've emailed your receipt to",
                                        style: TextStyle(color: AppColor.textGrey)),
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
                                                    child: TextField(
                                                      enabled: true,
                                                      controller: domainController,
                                                      decoration: InputDecoration(
                                                        counterText: '',
                                                        focusedBorder: InputBorder.none,
                                                        enabledBorder: InputBorder.none,
                                                        errorBorder: InputBorder.none,
                                                        disabledBorder: InputBorder.none,
                                                        isDense: true,
                                                        hintText: "Domain name",
                                                      ),
                                                    ))),
                                          ],
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: Dimens.paddingMedium),
                                    ElevatedButton(
                                        onPressed: () {},
                                        child: Text("Copy Link"),
                                        style: ElevatedButton.styleFrom(
                                            elevation: 0.0,
                                            primary: AppColor.primaryBlue,
                                            minimumSize: Size(double.infinity, Dimens.margeButtonEdge),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(Dimens.paddingDefault)))),
                                  ],
                                ),
                              )))),
                  SizedBox(height: Dimens.paddingMedium),
                ],)),
  );
}
