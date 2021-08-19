import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:up_reselling_webapp/application/app_color.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';
import 'package:up_reselling_webapp/bloc/check_domain_bloc/bloc.dart';
import 'package:up_reselling_webapp/bloc/domain_choose/bloc.dart';
import 'package:up_reselling_webapp/bloc/order_bloc/bloc.dart';
import 'package:up_reselling_webapp/models/domains_list.dart';

class BeckToHomeOpenWidget extends StatelessWidget {
  const BeckToHomeOpenWidget({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: Dimens.paddingMediumLarge,
        bottom: Dimens.paddingMediumLarge,
      ),
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child:
                  Image(image: AssetImage("assets/xumm_logo.png"), height: Dimens.margeButtonsEdge),
            ),
          ),
          Expanded(
            child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  icon:
                      Icon(Icons.arrow_back_ios, color: AppColor.black, size: Dimens.paddingMedium),
                  onPressed: () {},
                  label: Text(
                    "Beck To Home",
                    style: TextStyle(color: AppColor.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: AppColor.primaryGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimens.borderButtonRadius),
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

class BeckToHomeCloseWidget extends StatelessWidget {
  const BeckToHomeCloseWidget({Key? key}) : super(key: key);

  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(bottom: Dimens.paddingMedium),
        child: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Image(
                    image: AssetImage("assets/icon_light.png"), height: Dimens.margeButtonsEdge),
              ),
            ),
            Expanded(
              child: Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.arrow_back_ios,
                        color: AppColor.black, size: Dimens.paddingMedium),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    label: Text(
                      "Beck",
                      style: TextStyle(color: AppColor.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: AppColor.primaryGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Dimens.borderButtonRadius),
                      ),
                    ),
                  )),
            ),
          ],
        ),
      );
}

class CardUnstoppableWidget extends StatelessWidget {
  const CardUnstoppableWidget({Key? key}) : super(key: key);

  Widget build(BuildContext context) => Card(
        color: AppColor.backgroundLightBlue,
        child: Padding(
          padding: EdgeInsets.all(Dimens.paddingLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Image(
                  image: AssetImage("assets/unstoppable_domains_logo.png"),
                  height: Dimens.iconHeight,
                ),
              ),
              SizedBox(height: Dimens.paddingSemi),
              Text('Replace cryptocurrency addresses with\na human readable name',
                  style: TextStyle(fontSize: 14.0, color: AppColor.textGreyDark)),
            ],
          ),
        ),
      );
}

class TitleExtensionsWidget extends StatelessWidget {
  const TitleExtensionsWidget({Key? key, required this.domainName}) : super(key: key);
  final String domainName;

  Widget build(BuildContext context) => Align(
      alignment: Alignment.centerLeft,
      child: Container(
          child: Text("Extensions for \"" + "$domainName" + "\"",
              style: TextStyle(color: AppColor.textBlue, fontWeight: FontWeight.bold))));
}

class CardPurchaseWidget extends StatelessWidget {
  const CardPurchaseWidget({Key? key}) : super(key: key);

  Widget build(BuildContext context) => Card(
        color: AppColor.backgroundLightGrey,
        elevation: 0.0,
        child: Padding(
          padding: EdgeInsets.only(bottom: Dimens.paddingXSmall),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Purchase your\nBlockchain Domain",
                  style: TextStyle(
                      fontSize: 22.0, color: AppColor.black, fontWeight: FontWeight.bold)),
              SizedBox(height: Dimens.paddingSemi),
              Text("Please enter at least 6 Characters",
                  style: TextStyle(color: AppColor.textGrey)),
            ],
          ),
        ),
      );
}

class HelpCenterWidget extends StatelessWidget {
  const HelpCenterWidget({Key? key}) : super(key: key);

  Widget build(BuildContext context) => RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(text: "Have any issues? ", style: TextStyle(color: AppColor.textGreyDark)),
            TextSpan(
                text: "Help Center",
                style: TextStyle(color: AppColor.textBlue, fontWeight: FontWeight.bold)),
          ],
        ),
      );
}

class BottomTextUnstoppableWidget extends StatelessWidget {
  const BottomTextUnstoppableWidget({Key? key}) : super(key: key);

  Widget build(BuildContext context) => Column(
        children: [
          Text("Powered By",
              style: TextStyle(color: AppColor.textGreyMiddle, fontSize: Dimens.paddingTenFount)),
          Text("Unstoppable Domains",
              style: TextStyle(
                  color: AppColor.textGrey,
                  fontSize: Dimens.paddingSemi,
                  fontWeight: FontWeight.bold))
        ],
      );
}

//---------  Payment Page Widgets --------

class CardPaymentDataWidget extends StatelessWidget {
  final List<DomainItemCart> selectedDomainItems;

  const CardPaymentDataWidget({Key? key, required this.selectedDomainItems}) : super(key: key);

  Widget build(BuildContext context) => Card(
        color: AppColor.backgroundLightBlue,
        child: Padding(
          padding: EdgeInsets.all(Dimens.paddingXSmall),
          child: Container(
            height: 60,
            child: ListView.builder(
              // shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: selectedDomainItems.length,
              itemBuilder: (context, index) {
                final item = selectedDomainItems[index];
                return ListTile(
                  title:
                      Expanded(
                          child: Text("${item.nameDomain} - \$${item.domainItem!.price ~/ 100}",
                              style: TextStyle(
                                  fontSize: Dimens.paddingMedium,
                                  color: AppColor.black,
                                  fontWeight: FontWeight.bold))
                  ),
                );
              },
            ),
          ),
        ),
      );
}

class BottomTextPoweredWidget extends StatelessWidget {
  const BottomTextPoweredWidget({Key? key}) : super(key: key);

  Widget build(BuildContext context) => Column(
        children: [
          Text("Secured Checkout",
              style: TextStyle(color: AppColor.textGreyMiddle, fontSize: Dimens.paddingTenFount)),
          Text("Powered by Stripe",
              style: TextStyle(color: AppColor.primaryBlue, fontWeight: FontWeight.bold))
        ],
      );
}

class SpaceHeightWidget extends StatelessWidget {
  const SpaceHeightWidget({Key? key}) : super(key: key);

  Widget build(BuildContext context) => Expanded(
        child: Align(
          alignment: FractionalOffset.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text(""),
          ),
        ),
      );
}
