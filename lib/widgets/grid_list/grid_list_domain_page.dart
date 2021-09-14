import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:up_reselling_webapp/application/app_color.dart';
import 'package:up_reselling_webapp/application/app_text.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';
import 'package:up_reselling_webapp/bloc/domain_choose/domain_choose_bloc.dart';
import 'package:up_reselling_webapp/bloc/domain_choose/domain_choose_event.dart';
import 'package:up_reselling_webapp/bloc/domain_choose/domain_choose_state.dart';
import 'package:up_reselling_webapp/models/domains_list.dart';
import 'package:up_reselling_webapp/widgets/blockchain_domain_page/blockchain_domain_page.dart';
import 'package:up_reselling_webapp/widgets/blockchain_domain_page/suggestion_list_form.dart';

import '../general/widgets_repository.dart';
import 'grid_view_item_form.dart';

class GridListDomainPage extends StatefulWidget {
  final String domainsLogoSelected;
  final bool resellingValidate;
  final GetChooseDomainListCallback addSelectedDomainsCallback;

  GridListDomainPage({
    Key? key,
    required this.domainsLogoSelected,
    required this.resellingValidate,
    required this.addSelectedDomainsCallback,
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

  List<DomainItemCart> domains = [];
  bool showHideAddToCart = false;

  String oldDomainName = "";



  @override
  void didUpdateWidget(covariant GridListDomainPage oldWidget) {
    if(oldDomainName.isNotEmpty && oldDomainName != widget.domainsLogoSelected){
      stateGrid = true;
      showHideGridList = true;
    }
    super.didUpdateWidget(oldWidget);
  }


  @override
  Widget build(BuildContext context) {
    if (stateGrid) {
       oldDomainName = widget.domainsLogoSelected;
      context.read<DomainChooseBloc>().add(LoadDomains(widget.domainsLogoSelected));
    }

    return BlocListener<DomainChooseBloc, DomainChooseState>(
        listener: (context, state) {
          if (state is HasData) {
            listDomainAll.clear();
            listDomainSuggestion.clear();
            parsingJSONToDomainList(
                state.result, widget.domainsLogoSelected, widget.resellingValidate);
          }
        },
        child: Column(
          children: [
            SizedBox(height: Dimens.paddingMedium),
            BlocBuilder<DomainChooseBloc, DomainChooseState>(builder: (_, state) {
              if (state is HasData) {
                return Column(
                  children: [
                    Visibility(
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
                                child: GridViewItem(domain, _selectedDomains.contains(domain),
                                    widget.resellingValidate),
                              );
                            }).toList(),
                          ),
                        )),
                    SuggestionListForm(
                        resellingValidate: widget.resellingValidate,
                        listDomainSuggestion: listDomainSuggestion,
                        domainsLogoSelected: widget.domainsLogoSelected,
                        domainItemCart: (domain) =>
                            setState(() => widget.addSelectedDomainsCallback(domain)),
                        callbackShow: (val) => setState(() => showHideAddToCart = val),
                        stateGrid: (val) => setState(() => stateGrid = val),
                        remove: (val) => setState(() => listDomainSuggestion.removeAt(val))),
                  ],
                );
              } else {
                return CircularProgressIndicator();
              }
            }),
            SizedBox(height: Dimens.paddingMedium),
            Visibility(
              visible: widget.resellingValidate ? true : false,
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
                                    child: TextBold(
                                        text: selectedGridDomain != null
                                            ? "\$${selectedGridDomain!.price ~/ 100}"
                                            : "",
                                        fontSize: Dimens.paddingMedium,
                                        color: AppColor.primaryBlue),
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
                                      DomainItemCart domainItemCart = DomainItemCart(
                                          nameDomain: widget.domainsLogoSelected,
                                          domainItem: selectedGridDomain);
                                      domains.add(domainItemCart);
                                      widget.addSelectedDomainsCallback(domainItemCart);
                                    },
                                    label: Text(AppText.btn_add_to_cart),
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
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: Dimens.paddingSmall,
                                              bottom: Dimens.paddingSmall),
                                          child: Text("Available",
                                              style: TextStyle(
                                                  color: AppColor.black,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        Text(AppText.grid_available,
                                            style: TextStyle(color: AppColor.textGrey)),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: Dimens.paddingDefault),
                                    child: Icon(Icons.remove_red_eye_outlined,
                                        color: AppColor.textGrey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
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
        AppText.spinnerItems.forEach((element) {
          if (stateGrid) {
            listDomainAll.add(DomainItem(label: "", extension: element, price: 0));
          }
        });
        mapValue[domain].forEach((v) {
          listDomainSuggestion.add(DomainItem.fromJson(v));
        });

    }


    final ids = listDomainAll.map((e) => e.extension).toSet();
    listDomainAll.retainWhere((x) => ids.remove(x.extension));
  }
}

typedef void SuggestionDomainListCallback(DomainItemCart domainItemCart);
typedef void SuggestionShowCartCallback(bool showHideAddToCart);
typedef void SuggestionGridShowCartCallback(bool stateGrid);
typedef void SuggestionGridRemoveCallback(int index);
typedef void CheckoutDomainAddCallback(DomainItem? domainItemCart);
