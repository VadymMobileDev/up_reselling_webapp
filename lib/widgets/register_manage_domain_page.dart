import 'package:flutter/material.dart';
import 'package:up_reselling_webapp/application/app_color.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';

class RegisterManageDomainPage extends StatefulWidget {
  RegisterManageDomainPage({Key? key}) : super(key: key);

  @override
  RegisterManageDomainState createState() => RegisterManageDomainState();
}

class RegisterManageDomainState extends State<RegisterManageDomainPage> {
  bool _flag = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Dimens.paddingMedium),
        Row(
          children: [
            Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      setState(() => _flag = !_flag);
                    },
                    child: Text("Register Domain",
                        style: TextStyle(
                            color: _flag ? AppColor.white : AppColor.textGrey)),
                    style: ElevatedButton.styleFrom(
                        primary: _flag ? AppColor.primaryBlue : AppColor.primaryGrey,
                        minimumSize: Size(double.infinity, Dimens.margeButtonsEdge),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Dimens.paddingDefault),
                        )))),
            Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      setState(() => _flag = !_flag);
                    },
                    child: Text("Manage Domain",
                        style: TextStyle(
                            color: _flag ? AppColor.textGrey : AppColor.white)),
                    style: ElevatedButton.styleFrom(
                        primary: _flag ? AppColor.primaryGrey : AppColor.primaryBlue,
                        minimumSize: Size(double.infinity, Dimens.margeButtonsEdge),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Dimens.paddingDefault),
                        )))),
          ],
        ),
        SizedBox(height: Dimens.paddingMedium),
      ],
    );
  }
}
