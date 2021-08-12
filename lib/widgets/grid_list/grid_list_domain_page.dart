import 'package:flutter/material.dart';
import 'package:up_reselling_webapp/application/app_color.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';
import '../widgets_repository.dart';

class GridListDomainPage extends StatefulWidget {
  final List domainsGridList;
  final String domainsLogoSelected;

  GridListDomainPage({Key? key, required this.domainsGridList, required this.domainsLogoSelected})
      : super(key: key);

  @override
  _GridListDomainState createState() => _GridListDomainState();
}

class _GridListDomainState extends State<GridListDomainPage> {
  List _selectedIcons = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Dimens.paddingMedium),
        Container(
            child: GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          crossAxisCount: 3,
          children: widget.domainsGridList.map((domain) {
            return GestureDetector(
              onTap: () {
                _selectedIcons.clear();

                setState(() {
                  _selectedIcons.add(domain);
                });
              },
              child: GridViewItem(domain, _selectedIcons.contains(domain)),
            );
          }).toList(),
        )),
        SizedBox(height: Dimens.paddingMedium),
        AddToCartWidget(selectedDomain: widget.domainsLogoSelected),
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
