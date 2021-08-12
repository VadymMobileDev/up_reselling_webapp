import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:up_reselling_webapp/application/app_color.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';
import 'package:up_reselling_webapp/bloc/check_domain_bloc/bloc.dart';
import 'package:up_reselling_webapp/bloc/domain_choose/bloc.dart';
import 'package:up_reselling_webapp/bloc/order_bloc/bloc.dart';
import 'package:up_reselling_webapp/widgets/payment/payment_page.dart';

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

class AddToCartWidget extends StatelessWidget {
  final String selectedDomain;

  const AddToCartWidget({Key? key, required this.selectedDomain}) : super(key: key);

  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: EdgeInsets.all(Dimens.paddingSemi),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("$selectedDomain",
                            style: TextStyle(
                                fontSize: Dimens.paddingMedium,
                                color: AppColor.black,
                                fontWeight: FontWeight.bold)),
                        Padding(
                          padding: EdgeInsets.only(
                              top: Dimens.paddingSmall, bottom: Dimens.paddingSmall),
                          child: Text("\$100",
                              style: TextStyle(
                                  fontSize: Dimens.paddingMedium,
                                  color: AppColor.primaryBlue,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton.icon(
                          icon: Icon(Icons.add_shopping_cart,
                              color: AppColor.white, size: Dimens.paddingMediumLarge),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              return PaymentPage();
                            }));
                          },
                          label: Text("Add to Cart"),
                          style: ElevatedButton.styleFrom(
                              elevation: 0.0,
                              primary: AppColor.primaryBlue,
                              minimumSize: Size(double.infinity, Dimens.iconHeight),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(Dimens.paddingDefault))),
                        )),
                  ),
                ],
              ),
              SizedBox(height: Dimens.paddingSemi),
              Card(
                color: AppColor.backgroundLightBlue,
                child: Padding(
                  padding: EdgeInsets.all(Dimens.paddingDefault),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  top: Dimens.paddingSmall, bottom: Dimens.paddingSmall),
                              child: Text("Available",
                                  style: TextStyle(
                                      color: AppColor.black, fontWeight: FontWeight.bold)),
                            ),
                            Text("This domain is available for purchase",
                                style: TextStyle(color: AppColor.textGrey)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: Dimens.paddingDefault),
                        child: Icon(Icons.remove_red_eye_outlined, color: AppColor.textGrey),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
}

//---------  Payment Page Widgets --------

class CardPaymentDataWidget extends StatelessWidget {
  const CardPaymentDataWidget({Key? key}) : super(key: key);

  Widget build(BuildContext context) => Card(
        color: AppColor.backgroundLightBlue,
        child: Padding(
          padding: EdgeInsets.all(Dimens.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Replace cryptocurrency addresses  - 40\$'),
              SizedBox(height: Dimens.paddingSemi),
              Text('Replace cryptocurrency addresses ')
            ],
          ),
        ),
      );
}

class BottomTextPoweredWidget extends StatelessWidget {
  const BottomTextPoweredWidget({Key? key}) : super(key: key);

  Widget build(BuildContext context) => Column(
        children: [
          SizedBox(height: Dimens.paddingXLarge),
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
///////


class HomeScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<CheckDomainBloc>().add(LoadCheckDomain("unstoppabledomains", "vadym.crypto"));
    return Container(child: BlocBuilder<CheckDomainBloc, CheckDomainState>(builder: (_, state) {
      if (state is HasDataCheckDomain) {
        print("------resultCheckDomainData : ${state.result.domain.name}");

// succeeds - is dynamic
// gives List<dynamic>
//         List d = List<dynamic>.from(state.result.crypto);
//         List de = state.result.crypto.cast<DomainName>();
//
//         List list = state.result.crypto.toList();
//         print("------list : ${list.length}");

        return Text("GamesHasData  ${state.result}");
      } else if (state is LoadingCheckDomain) {
        return CircularProgressIndicator();
      } else if (state is NoDataCheckDomain) {
        return Container(
          child: Center(
            child: Text(state.message),
          ),
        );
      } else if (state is NoInternetCheckDomain) {
        return Text('No Internet Connection');
      } else {
        return CircularProgressIndicator();
      }
    }));
  }
}


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<DomainChooseBloc>().add(LoadDomains("crypto"));
    return Container(child: BlocBuilder<DomainChooseBloc, DomainChooseState>(builder: (_, state) {
      if (state is HasData) {
        print("------resultGamesHasData : ${state.result.crypto}");

        var target_list_1 = [] + state.result.crypto;

// succeeds - is dynamic
// gives List<dynamic>
//         List d = List<dynamic>.from(state.result.crypto);
//         List de = state.result.crypto.cast<DomainName>();
//
//         List list = state.result.crypto.toList();
//         print("------list : ${list.length}");

        return Text("GamesHasData  ${state.result}");
      } else if (state is Loading) {
        return CircularProgressIndicator();
      } else if (state is NoData) {
        return Container(
          child: Center(
            child: Text(state.message),
          ),
        );
      } else if (state is NoInternet) {
        return Text('No Internet Connection');
      } else {
        return CircularProgressIndicator();
      }
    }));
  }
}

class HomeScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<OrderBloc>().add(LoadOrder());
    return Container(child: BlocBuilder<OrderBloc, OrderState>(builder: (_, state) {
      if (state is HasDataOrder) {
        print("------resultOrderHasData : ${state.result.orderNumber}");

        return Text("GamesHasData  ${state}");
      } else if (state is LoadingOrder) {
        return CircularProgressIndicator();
      } else if (state is NoDataOrder) {
        return Container(
          child: Center(
            child: Text(state.message),
          ),
        );
      } else if (state is NoInternetOrder) {
        return Text('No Internet Connection');
      } else {
        return CircularProgressIndicator();
      }
    }));
  }
}
