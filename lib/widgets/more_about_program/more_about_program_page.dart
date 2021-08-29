import 'package:flutter/material.dart';
import 'package:up_reselling_webapp/application/app_color.dart';
import 'package:up_reselling_webapp/application/app_text.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';

import '../widgets_repository.dart';

class MoreAboutProgramingPage extends StatefulWidget {
  MoreAboutProgramingPage({Key? key}) : super(key: key);

  @override
  _MoreAboutProgramingState createState() => _MoreAboutProgramingState();
}

class _MoreAboutProgramingState extends State<MoreAboutProgramingPage> {
  TextEditingController domainController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColor.backgroundLightBlue,
        body: Padding(
            padding: spacePadding,
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
                          TextBold(
                              text: AppText.more_give,
                              fontSize: Dimens.borderButtonRadius,
                              color: AppColor.textBlue),
                          SizedBox(height: Dimens.paddingMediumLarge),
                          Text(AppText.more_refer,
                              style: TextStyle(color: AppColor.textGrey),
                              textAlign: TextAlign.center),
                          SizedBox(height: Dimens.paddingMediumLarge),
                          Card(
                            color: AppColor.backgroundLightGrey,
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(Dimens.paddingDefault)),
                                side: BorderSide(width: 2, color: AppColor.borderCardGrey)),
                            child: Padding(
                              padding: EdgeInsets.all(Dimens.paddingSemi),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: TextField(
                                            enabled: false,
                                            maxLines: 2,
                                            controller: domainController,
                                            decoration: InputDecoration(
                                              counterText: '',
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                              isDense: true,
                                              hintText:
                                                  "https://unstoppabledomains.com/r/2 2b214f68524f2",
                                              hintStyle: TextStyle(color: AppColor.black),
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
                          SizedBox(height: Dimens.borderButtonRadius),
                          Row(
                            children: [
                              Expanded(
                                child: CircleAvatar(
                                  radius: 28,
                                  child: Image.asset("assets/icon_light.png"),
                                ),
                              ),
                              Expanded(
                                child: CircleAvatar(
                                  radius: 28,
                                  child: Image.asset("assets/icon_light.png"),
                                ),
                              ),
                              Expanded(
                                child: CircleAvatar(
                                  radius: 28,
                                  child: Image.asset("assets/icon_light.png"),
                                ),
                              ),
                              Expanded(
                                child: CircleAvatar(
                                  radius: 28,
                                  child: Image.asset("assets/icon_light.png"),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Dimens.paddingMedium),
                        ],
                      ),
                    )))),
                SizedBox(height: Dimens.paddingLarge),
                TextBold(
                    text: AppText.more_learn,
                    fontSize: Dimens.paddingMedium,
                    color: AppColor.textBlue)
              ],
            )),
      );
}
