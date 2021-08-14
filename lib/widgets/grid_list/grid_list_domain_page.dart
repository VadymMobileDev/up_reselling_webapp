import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:up_reselling_webapp/application/app_color.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';
import 'package:up_reselling_webapp/bloc/domain_choose/domain_choose_bloc.dart';
import 'package:up_reselling_webapp/bloc/domain_choose/domain_choose_event.dart';
import 'package:up_reselling_webapp/bloc/domain_choose/domain_choose_state.dart';
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
  List _selectedIcons = [];
  List listDomainPriceSort = [];
  bool stateGrid = true;
  dynamic selectedGridDomain;

  @override
  Widget build(BuildContext context) {
    if (stateGrid) {
      context.read<DomainChooseBloc>().add(LoadDomains("crypto"));
      print("------ ${selectedGridDomain.toString()}");
    }
    return Column(
      children: [
        SizedBox(height: Dimens.paddingMedium),
        BlocBuilder<DomainChooseBloc, DomainChooseState>(builder: (_, state) {
          if (state is HasData) {
            state.result.crypto.forEach((domains) {
              if (domains['price'] == (widget.resellingPrice! * 1000)) {
                if (stateGrid){
                  listDomainPriceSort.add(domains);
                }
              }
            });
            return Container(
                child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              crossAxisCount: 3,
              children: listDomainPriceSort.map((domain) {
                return GestureDetector(
                  onTap: () {
                    stateGrid = false;
                    _selectedIcons.clear();
                    setState(() {
                      _selectedIcons.add(domain);

                      selectedGridDomain = domain;
                    });
                  },
                  child: GridViewItem(domain, _selectedIcons.contains(domain)),
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
}

class GridViewItem extends StatelessWidget {
  final dynamic item;
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
                Text(item["extension"],
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
                    Text("\$${item["price"] ~/ 100}"),
                  ],
                )
              ],
            )));
  }
}
