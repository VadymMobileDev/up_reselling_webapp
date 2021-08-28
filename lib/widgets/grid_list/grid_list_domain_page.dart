import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:up_reselling_webapp/application/app_color.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';
import 'package:up_reselling_webapp/bloc/domain_choose/domain_choose_bloc.dart';
import 'package:up_reselling_webapp/bloc/domain_choose/domain_choose_event.dart';
import 'package:up_reselling_webapp/bloc/domain_choose/domain_choose_state.dart';
import 'package:up_reselling_webapp/models/domains_list.dart';
import 'package:up_reselling_webapp/widgets/blockchain_domain_page/blockchain_domain_page.dart';
import 'package:up_reselling_webapp/widgets/blockchain_domain_page/check_domain_page.dart';

import 'grid_view_item_form.dart';

class GridListDomainPage extends StatefulWidget {
  final String domainsLogoSelected;
  final bool resellingValidate;
  final ShowHideCheckCallback callback;
  final List<String> spinnerItems;

  GridListDomainPage({
    Key? key,
    required this.domainsLogoSelected,
    required this.resellingValidate,
    required this.callback,
    required this.spinnerItems,
  }) : super(key: key);

  @override
  _GridListDomainState createState() => _GridListDomainState();
}

class _GridListDomainState extends State<GridListDomainPage> {
  List<DomainItem> _selectedDomains = [];
  List<DomainItem> listDomainAll = [];
  List<DomainItem> listDomainSuggestion = [];
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
                state.result, widget.domainsLogoSelected, widget.resellingValidate);
            return Visibility(
                visible: showHideGridList,
                child: Container(
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    crossAxisCount: 3,
                    children: listDomainAll.map((domain) {
                      return GestureDetector(
                        onTap: () {
                          if (widget.resellingValidate) {
                            stateGrid = false;
                            _selectedDomains.clear();
                            setState(() {
                              _selectedDomains.add(domain);
                              selectedGridDomain = domain;
                            });
                          }
                        },
                        child: GridViewItem(
                            domain, _selectedDomains.contains(domain), widget.resellingValidate),
                      );
                    }).toList(),
                  ),
                ));
          } else {
            return CircularProgressIndicator();
          }
        }),
        Visibility(
          visible: widget.resellingValidate ? false : true,
          child: Column(
            children: [
              SizedBox(height: Dimens.paddingMedium),
              Text("Didn't find what you are looking for? How about one of those?",
                  style: TextStyle(color: AppColor.textBlue, fontWeight: FontWeight.bold)),
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: listDomainSuggestion.length,
                  itemBuilder: (context, index) {
                    final item = listDomainSuggestion[index];
                    return ListTile(
                      title: Row(
                        children: [
                          Expanded(
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("${item.label}.${item.extension}",
                                      style: TextStyle(
                                          fontSize: Dimens.paddingSemi,
                                          color: AppColor.black,
                                          fontWeight: FontWeight.bold)))),
                          Align(
                              alignment: Alignment.center,
                              child: Text("\$${item.price ~/ 100}.00",
                                  style: TextStyle(
                                      fontSize: Dimens.paddingSemi,
                                      color: AppColor.textBlue,
                                      fontWeight: FontWeight.bold))),
                          Expanded(
                            child: Align(
                                alignment: Alignment.center,
                                child: ElevatedButton.icon(
                                  icon: Icon(Icons.add_shopping_cart,
                                      color: AppColor.white, size: Dimens.paddingMedium),
                                  onPressed: () {
                                    setState(() {
                                      _selectedDomains.add(item);
                                    });
                                  },
                                  label: Text("Add to Cart",
                                      style: TextStyle(fontSize: Dimens.paddingSemi)),
                                  style: ElevatedButton.styleFrom(
                                      primary: AppColor.primaryBlue,
                                      minimumSize: Size(double.minPositive, Dimens.paddingLarge),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(Dimens.paddingSmall))),
                                )),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
        SizedBox(height: Dimens.paddingMedium),
        Visibility(
          visible: showHideGridList,
          child: Visibility(
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
                                },
                                label: Text("Add to Cart"),
                                style: ElevatedButton.styleFrom(
                                    elevation: 0.0,
                                    primary: AppColor.primaryBlue,
                                    minimumSize: Size(double.infinity, Dimens.iconHeight),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(Dimens.paddingDefault))),
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
                            setState(() {
                              showHideAddToCart = true;
                              showHideGridList = false;
                              widget.callback(true);
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
                                child:
                                    Icon(Icons.remove_red_eye_outlined, color: AppColor.textGrey),
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
        ),
        CheckoutDomainWidget(
            selectedDomainItemCarts: selectedDomainItemCart, showHide: showHideAddToCart),
        SizedBox(height: Dimens.paddingMedium),
      ],
    );
  }

  parsingJSONToDomainList(String json, String domain, bool resellingValidate) {
    Map mapValue = jsonDecode(json);
    if (resellingValidate) {
      mapValue[domain].forEach((v) {
        if (stateGrid) {
          listDomainAll.add(DomainItem.fromJson(v));
        }
      });
    } else {
      widget.spinnerItems.forEach((element) {
        listDomainAll.add(DomainItem(label: "", extension: element, price: 0));
      });
      mapValue[domain].forEach((v) {
        listDomainSuggestion.add(DomainItem.fromJson(v));
      });
    }
    final ids = listDomainAll.map((e) => e.extension).toSet();
    listDomainAll.retainWhere((x) => ids.remove(x.extension));
  }
}


