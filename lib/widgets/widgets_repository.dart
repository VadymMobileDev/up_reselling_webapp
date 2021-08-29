import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:up_reselling_webapp/application/app_color.dart';
import 'package:up_reselling_webapp/application/app_text.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';
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
                    AppText.x_beck,
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
              TextBold(
                  text: AppText.x_purchase, fontSize: Dimens.fontSizeXL, color: AppColor.black),
              SizedBox(height: Dimens.paddingSemi),
              Text(AppText.x_6_characters, style: TextStyle(color: AppColor.textGrey)),
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
          Text(AppText.x_powered,
              style: TextStyle(color: AppColor.textGreyMiddle, fontSize: Dimens.paddingTenFount)),
          TextBold(
              text: AppText.x_unstoppable, fontSize: Dimens.paddingSemi, color: AppColor.textGrey),
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
              padding: EdgeInsets.zero,
              itemCount: selectedDomainItems.length,
              itemBuilder: (context, index) {
                final item = selectedDomainItems[index];
                return ListTile(
                    title: TextBold(
                        text: "${item.nameDomain} - \$${item.domainItem!.price ~/ 100}",
                        fontSize: Dimens.paddingMedium,
                        color: AppColor.black));
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

  Widget build(BuildContext context) => Align(
        alignment: FractionalOffset.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(bottom: Dimens.paddingXLarge),
          child: Text(""),
        ),
      );
}

class TextBold extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;

  const TextBold({
    Key? key,
    required this.text,
    required this.fontSize,
    required this.color,
  }) : super(key: key);

  Widget build(BuildContext context) =>
      Text(text, style: TextStyle(fontSize: fontSize, color: color, fontWeight: FontWeight.bold));
}

const spacePadding = const EdgeInsets.only(
  top: Dimens.paddingLarge,
  left: Dimens.paddingMediumLarge,
  right: Dimens.paddingMediumLarge,
  bottom: Dimens.paddingMediumLarge,
);
