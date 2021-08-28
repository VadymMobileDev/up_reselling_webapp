
import 'package:flutter/material.dart';
import 'package:up_reselling_webapp/application/app_color.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';
import 'package:up_reselling_webapp/models/domains_list.dart';

class GridViewItem extends StatelessWidget {
  final DomainItem item;
  final bool _isSelected;
  final bool resellingValidate;

  GridViewItem(this.item, this._isSelected, this.resellingValidate);

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
                    resellingValidate
                        ? Icon(Icons.check_circle, color: AppColor.green)
                        : Icon(Icons.error_outline, color: AppColor.textGrey),
                    Text(resellingValidate ? "\$${item.price ~/ 100}" : ""),
                  ],
                )
              ],
            )));
  }
}