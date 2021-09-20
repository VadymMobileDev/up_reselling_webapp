import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:up_reselling_webapp/application/app_color.dart';
import 'package:up_reselling_webapp/application/app_const.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';
import 'package:up_reselling_webapp/bloc/currency_bloc/currency_domain_bloc.dart';
import 'package:up_reselling_webapp/bloc/currency_bloc/currency_domain_event.dart';
import 'package:up_reselling_webapp/bloc/currency_bloc/currency_domain_state.dart';
import 'package:up_reselling_webapp/models/domains_list.dart';
import 'package:up_reselling_webapp/widgets/payment/payment_page.dart';

class CheckoutDomainWidget extends StatefulWidget {
  final List<DomainItemCart> selectedDomainItemCarts;

  const CheckoutDomainWidget({Key? key, required this.selectedDomainItemCarts}) : super(key: key);

  @override
  CheckoutDomainWidgetState createState() => CheckoutDomainWidgetState();
}

class CheckoutDomainWidgetState extends State<CheckoutDomainWidget> {
  double currency = 0.0;

  Widget build(BuildContext context) {
    context
        .read<CurrencyDomainBloc>()
        .add(LoadCurrencyDomain(AppConst.x_api_key, AppConst.x_api_secret, AppConst.currency));

    return BlocListener<CurrencyDomainBloc, CurrencyDomainState>(
      listener: (context, state) {
        if (state is HasDataCurrencyDomain) {
          currency = state.result.XRP;
        }
      },
      child: Visibility(
        visible: widget.selectedDomainItemCarts.isNotEmpty,
        child: Card(
          color: AppColor.backgroundLightBlue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                color: AppColor.white,
                child: Padding(
                    padding: EdgeInsets.only(left: Dimens.paddingMedium, top: Dimens.paddingMedium),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  Text("Cart: ",
                                      style: TextStyle(
                                          fontSize: Dimens.paddingMedium,
                                          color: AppColor.black,
                                          fontWeight: FontWeight.bold)),
                                  Text(" ${widget.selectedDomainItemCarts.length} item(s)",
                                      style: TextStyle(
                                          fontSize: Dimens.paddingMedium, color: AppColor.black)),
                                ],
                              ),
                              Container(
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: widget.selectedDomainItemCarts.length,
                                  itemBuilder: (context, index) {
                                    final item = widget.selectedDomainItemCarts[index];
                                    return ListTile(
                                      title: Row(
                                        children: [
                                          Expanded(
                                              child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "${item.domainItem?.label}.${item.domainItem?.extension} - \$${item.domainItem!.price ~/ 100}",
                                                  style: TextStyle(
                                                      fontSize: Dimens.paddingMedium,
                                                      color: AppColor.black,
                                                      fontWeight: FontWeight.bold)),
                                              Text("${(item.domainItem!.price ~/ 100)* currency} XRP",
                                                  style: TextStyle(color: AppColor.primaryBlue))
                                            ],
                                          )),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: IconButton(
                                                icon: Icon(Icons.clear),
                                                onPressed: () {
                                                  setState(() {
                                                    widget.selectedDomainItemCarts.removeAt(index);
                                                  });
                                                }),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
              Card(
                color: AppColor.backgroundLightBlue,
                elevation: 0.0,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(left: Dimens.paddingDefault),
                              child: Row(
                                children: [
                                  Text("Total: ",
                                      style: TextStyle(
                                          color: AppColor.black, fontWeight: FontWeight.bold)),
                                  Text(" \$${totalAmount(widget.selectedDomainItemCarts)}",
                                      style: TextStyle(
                                          color: AppColor.primaryBlue,
                                          fontWeight: FontWeight.bold)),
                                ],
                              )),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(
                            left: Dimens.paddingTenFount,
                            right: Dimens.paddingTenFount,
                            top: Dimens.paddingSmall,
                            bottom: Dimens.paddingSmall,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                return PaymentPage(
                                    selectedDomainItems: widget.selectedDomainItemCarts, currencyDomain: currency);
                              }));
                            },
                            child: Text("Checkout"),
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
              ),
              SizedBox(height: Dimens.paddingMedium),
            ],
          ),
        ),
      ),
    );
  }

  String totalAmount(List<DomainItemCart> selectedDomainItemCarts) {
    int total = 0;
    selectedDomainItemCarts.forEach((v) {
      total += v.domainItem!.price ~/ 100;
    });
    return total.toString();
  }
}
