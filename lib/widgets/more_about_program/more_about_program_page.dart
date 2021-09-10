import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:up_reselling_webapp/application/app_color.dart';
import 'package:up_reselling_webapp/application/app_text.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';
import 'package:up_reselling_webapp/widgets/general/web_view_page.dart';

import '../general/widgets_repository.dart';

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
                      padding: const EdgeInsets.all(Dimens.paddingMedium),
                      child: Column(
                        children: <Widget>[
                          FittedBox(
                            child: Image.asset("assets/frame.png"),
                            fit: BoxFit.fill,
                          ),
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
                                              hintText: AppText.more_url_copy,
                                              hintStyle: TextStyle(color: AppColor.black),
                                            ),
                                          ))),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: Dimens.paddingMedium),
                          ElevatedButton(
                              onPressed: () {
                                Clipboard.setData(ClipboardData(text: AppText.more_url_copy));
                              },
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
                              _circleAvatar(AppText.more_url_twitter, "assets/twitter.png"),
                              _circleAvatar(AppText.more_url_facebook, "assets/facebook.png"),
                              _circleAvatar(AppText.more_url_instagram, "assets/messenger.png"),
                              _circleAvatar(AppText.more_url_support, "assets/mail.png")
                            ],
                          ),
                          SizedBox(height: Dimens.paddingMedium),
                        ],
                      ),
                    )))),
                SizedBox(height: Dimens.paddingMedium),
                TextBold(
                    text: AppText.more_learn,
                    fontSize: Dimens.paddingMedium,
                    color: AppColor.textBlue)
              ],
            )),
      );

  Widget _circleAvatar(String url, String image) => Expanded(
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewPage(url: url)));
          },
          child: CircleAvatar(
            radius: 28,
            child: Image.asset(image),
          ),
        ),
      );
}
