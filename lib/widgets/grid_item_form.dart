import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:up_reselling_webapp/application/app_color.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';
import 'package:up_reselling_webapp/models/grid_domain.dart';

class GridItem extends StatefulWidget {
  final Key key;
  final DomainGrid item;
  final ValueChanged<bool> isSelected;

  GridItem({required this.item, required this.isSelected, required this.key});

  @override
  _GridItemState createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.zero,
        color: AppColor.backgroundLightGrey,
        shape: RoundedRectangleBorder(side: BorderSide(width: 1, color: AppColor.borderCardGrey)),
        elevation: 0.0,
        // child: InkWell(
        //     onTap: () {
        //       // setState(() {
        //       //   isSelected = !isSelected;
        //       //   widget.isSelected(isSelected);
        //       // });
        //     },
        child: Padding(
            padding: EdgeInsets.only(top: Dimens.paddingLarge, bottom: Dimens.paddingMedium),
            child: Column(
              children: <Widget>[
                Text(widget.item.domainName,
                    style: TextStyle(
                        fontSize: Dimens.paddingMedium,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Checkbox(
                      value: isSelected,
                      shape: CircleBorder(),
                      activeColor: AppColor.green,
                      onChanged: (bool? newValue) {
                        setState(() {
                          isSelected = !isSelected;
                          widget.isSelected(isSelected);
                        });
                      },
                    ),
                    Text("\$ " + widget.item.price),
                  ],
                )
              ],
            )));
  }
}
