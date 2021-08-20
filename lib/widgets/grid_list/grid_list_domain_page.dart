import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:up_reselling_webapp/application/app_color.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';
import 'package:up_reselling_webapp/bloc/domain_choose/domain_choose_bloc.dart';
import 'package:up_reselling_webapp/bloc/domain_choose/domain_choose_event.dart';
import 'package:up_reselling_webapp/bloc/domain_choose/domain_choose_state.dart';
import 'package:up_reselling_webapp/models/domains_list.dart';
import 'package:up_reselling_webapp/widgets/payment/payment_page.dart';
import '../widgets_repository.dart';

class GridListDomainPage extends StatefulWidget {
  final String domainsLogoSelected;
  final int? resellingPrice;

  GridListDomainPage({
    Key? key,
    required this.domainsLogoSelected,
    required this.resellingPrice,
  }) : super(key: key);

  @override
  _GridListDomainState createState() => _GridListDomainState();
}

class _GridListDomainState extends State<GridListDomainPage> {
  List<DomainItem> _selectedDomains = [];
  List<DomainItem> listDomainPriceSort = [];
  bool stateGrid = true;
  DomainItem? selectedGridDomain;
  bool showHideGridList = true;

  late List<DomainItemCart> selectedDomainItemCart = [];
  bool showHideAddToCart = false;

  @override
  Widget build(BuildContext context) {
    if (stateGrid) {
      context.read<DomainChooseBloc>().add(LoadDomains(widget.domainsLogoSelected));
    }
    return Column(
      children: [
        SizedBox(height: Dimens.paddingMedium),
        BlocBuilder<DomainChooseBloc, DomainChooseState>(builder: (_, state) {
          if (state is HasData) {
            parsingJSONToDomainList(
                state.result, widget.domainsLogoSelected, widget.resellingPrice!);
            return Visibility(
                visible: showHideGridList,
                child: Container(
                child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              crossAxisCount: 3,
              children: listDomainPriceSort.map((domain) {
                return GestureDetector(
                  onTap: () {
                    stateGrid = false;
                    _selectedDomains.clear();
                    setState(() {
                      _selectedDomains.add(domain);

                      selectedGridDomain = domain;
                    });
                  },
                  child: GridViewItem(domain, _selectedDomains.contains(domain)),
                );
              }).toList(),
                ),
            ));
          } else {
            return CircularProgressIndicator();
          }
        }),
        SizedBox(height: Dimens.paddingMedium),

        Visibility(
          visible: selectedGridDomain != null ? true : false,
          child: Card(
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
                            Text("${widget.domainsLogoSelected}",
                                style: TextStyle(
                                    fontSize: Dimens.paddingMedium,
                                    color: AppColor.black,
                                    fontWeight: FontWeight.bold)),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: Dimens.paddingSmall, bottom: Dimens.paddingSmall),
                              child: Text(
                                  selectedGridDomain != null
                                      ? "\$${selectedGridDomain!.price ~/ 100}"
                                      : "",
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
                                selectedDomainItemCart.add(DomainItemCart(
                                    nameDomain: widget.domainsLogoSelected,
                                    domainItem: selectedGridDomain));
                                // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                //   return PaymentPage();
                                // }));
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
                      child: GestureDetector(
                        onTap: () {
                          print("Container clicked");
                          setState(() {
                            showHideAddToCart = true;
                            showHideGridList = false;
                            // CheckoutDomainWidget(selectedDomainItemCarts: selectedDomainItemCart);
                          });
                        },
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
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        CheckoutDomainWidget(selectedDomainItemCarts: selectedDomainItemCart, showHide: showHideAddToCart),
        SizedBox(height: Dimens.paddingMedium),
      ],
    );
  }
  parsingJSONToDomainList(String json, String domain, int price) {
    Map mapValue = jsonDecode(json);
    mapValue[domain].forEach((v) {
      if (DomainItem.fromJson(v).price <= price * 100) {
        if (stateGrid) {
          listDomainPriceSort.add(DomainItem.fromJson(v));
        }
      }
    });
  }
}

class GridViewItem extends StatelessWidget {
  final DomainItem item;
  final bool _isSelected;

  GridViewItem(this.item, this._isSelected);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.zero,
        color: _isSelected ? AppColor.primaryBlue : AppColor.backgroundLightGrey,
        shape: RoundedRectangleBorder(side: BorderSide(width: 1, color: AppColor.borderCardGrey)),
        elevation: 0.0,
        child: Padding(
            padding: EdgeInsets.only(top: Dimens.paddingLarge, bottom: Dimens.paddingMedium),
            child: Column(
              children: <Widget>[
                Text(item.extension,
                    style: TextStyle(
                        fontSize: Dimens.paddingMedium,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Checkbox(
                      value: true,
                      shape: CircleBorder(),
                      activeColor: AppColor.green,
                      onChanged: (bool? newValue) {},
                    ),
                    Text("\$${item.price ~/ 100}"),
                  ],
                )
              ],
            )));
  }
}

class CheckoutDomainWidget extends StatefulWidget {
  final List<DomainItemCart> selectedDomainItemCarts;
  final bool showHide;

  const CheckoutDomainWidget({Key? key, required this.selectedDomainItemCarts, required this.showHide}) : super(key: key);

  @override
  CheckoutDomainWidgetState createState() => CheckoutDomainWidgetState();
}

class CheckoutDomainWidgetState extends State<CheckoutDomainWidget> {
  Widget build(BuildContext context) => Visibility(
      visible: widget.showHide,
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
                                          fontSize: Dimens.paddingMedium,
                                          color: AppColor.black)),
                                ],
                              ),
                              Container(
                                height: 60,
                                child: ListView.builder(
                                  // shrinkWrap: true,
                                  // physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemCount: widget.selectedDomainItemCarts.length,
                                  itemBuilder: (context, index) {
                                    final item = widget.selectedDomainItemCarts[index];

                                    return ListTile(
                                      title: Row(
                                        children: [
                                      Expanded(
                                      child: Text("${item.nameDomain} - \$${item.domainItem!.price ~/ 100}",
                                          style: TextStyle(
                                          fontSize: Dimens.paddingMedium,
                                          color: AppColor.black,
                                          fontWeight: FontWeight.bold))
                                      ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: IconButton(icon: Icon(Icons.clear), onPressed: () {
                                                setState(() {
                                                  widget.selectedDomainItemCarts.removeAt(index);
                                                });
                                              }),
                                            ),
                                          )                                        ],
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
                                    style:
                                    TextStyle(color: AppColor.black, fontWeight: FontWeight.bold)),
                                Text(" \$${totalAmount(widget.selectedDomainItemCarts) }",
                                    style:
                                    TextStyle(color: AppColor.primaryBlue, fontWeight: FontWeight.bold)),
                              ],
                            )
                          ),
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
                                return PaymentPage(selectedDomainItems: widget.selectedDomainItemCarts);
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
            ],
          ),
          ),
      );

  String totalAmount(List<DomainItemCart> selectedDomainItemCarts){
    int total = 0;
    selectedDomainItemCarts.forEach((v) {
      total += v.domainItem!.price ~/ 100;
    });
    return total.toString();
  }

}
