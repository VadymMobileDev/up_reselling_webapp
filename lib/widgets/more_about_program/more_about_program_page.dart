import 'package:flutter/material.dart';
import 'package:up_reselling_webapp/application/app_color.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';

const _spacePadding = const EdgeInsets.only(
  top: Dimens.paddingLarge,
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
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColor.backgroundLightBlue,
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
                          Text("Give \$10, Get \$10",
                              style: TextStyle(
                                  fontSize: Dimens.borderButtonRadius,
                                  color: AppColor.textBlue,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: Dimens.paddingMediumLarge),
                          Text(
                              "Refer a friend with a \$10 credit and \n earn \$10 credit after they make their \nfirst purchase.",
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
                                              hintText: "https://unstoppabledomains.com/r/2 2b214f68524f2",
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
                        ],
                      ),
                    )))),
                SizedBox(height: Dimens.paddingLarge),
                Text("Learn more about the program",
                    style: TextStyle(
                        fontSize: Dimens.paddingMedium,
                        color: AppColor.textBlue,
                        fontWeight: FontWeight.bold)),
              ],
            )),
      );
}
