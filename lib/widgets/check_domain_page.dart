import 'package:flutter/material.dart';
import 'package:up_reselling_webapp/application/app_color.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';

class CheckDomainPage extends StatefulWidget {
  CheckDomainPage({Key? key}) : super(key: key);

  @override
  CheckDomainState createState() => CheckDomainState();
}

class CheckDomainState extends State<CheckDomainPage> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
                child: Text("wwumwallet",
                    style: TextStyle(color: AppColor.black, fontSize: Dimens.paddingMedium)),
              )),
              ElevatedButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Container(
                      child: Text(".crypto", style: TextStyle(color: AppColor.black)),
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(4, 0, 10, 0),
                        child: Icon(Icons.arrow_drop_down,
                            color: AppColor.textGreyDark, size: Dimens.paddingMedium)),
                  ],
                ),
                style:
                    ElevatedButton.styleFrom(primary: AppColor.backgroundLightGrey, elevation: 0.0),
              )
            ],
          ),
        ),
      ),
      SizedBox(height: Dimens.paddingMedium),
      ElevatedButton(
          onPressed: () {},
          child: Text("Check Domain"),
          style: ElevatedButton.styleFrom(
              primary: AppColor.primaryBlue,
              minimumSize: Size(double.infinity, Dimens.margeButtonEdge),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimens.paddingDefault)))),
      SizedBox(height: Dimens.paddingMediumLarge),
    ]);
  }
}
