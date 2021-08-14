import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:up_reselling_webapp/application/app_color.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';
import 'package:up_reselling_webapp/bloc/domain_choose/domain_choose_bloc.dart';
import 'package:up_reselling_webapp/bloc/domain_choose/domain_choose_event.dart';
import 'package:up_reselling_webapp/bloc/domain_choose/domain_choose_state.dart';
import 'package:up_reselling_webapp/models/domains_list.dart';
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
  List <DomainItem> _selectedDomains = [];
  List <DomainItem> listDomainPriceSort = [];
  bool stateGrid = true;
  DomainItem? selectedGridDomain;



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
            parsingJSONToDomainList(state.result, widget.domainsLogoSelected, widget.resellingPrice!);
            return Container(child: GridView.count(
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
            ));
          } else {
            return CircularProgressIndicator();
          }
        }),
        SizedBox(height: Dimens.paddingMedium),
        AddToCartWidget(selectedDomain: widget.domainsLogoSelected, selectedGridDomain: selectedGridDomain),
      ],
    );
  }

  parsingJSONToDomainList(String json, String domain, int price) {
    Map mapValue = jsonDecode(json);
    mapValue[domain].forEach((v) {
      if(DomainItem.fromJson(v).price == price * 100) {
        if (stateGrid){
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
