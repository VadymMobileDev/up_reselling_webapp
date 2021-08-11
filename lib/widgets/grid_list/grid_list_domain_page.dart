import 'package:flutter/material.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';
import 'grid_item_form.dart';

class GridListDomainPage extends StatefulWidget {
  final List domainsGridList;

  GridListDomainPage({Key? key, required this.domainsGridList}) : super(key: key);

  @override
  _GridListDomainState createState() => _GridListDomainState();
}

class _GridListDomainState extends State<GridListDomainPage> {
  late List<dynamic> selectedList = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Dimens.paddingMedium),
        Container(
          child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemCount: widget.domainsGridList.length,
              itemBuilder: (BuildContext ctx, index) {
                return GridItem(
                    item: widget.domainsGridList[index],
                    isSelected: (bool value) {
                      setState(() {
                        if (value) {
                          selectedList.add(widget.domainsGridList[index]);
                        } else {
                          selectedList.remove(widget.domainsGridList[index]);
                        }
                      });
                    },
                    key: Key(widget.domainsGridList[index]['extension']));
              }),
        ),
        Container(
          width: MediaQuery.of(context).size.shortestSide,
          child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: selectedList.length > 0 ? selectedList.length : 1),
              itemCount: selectedList.length,
              itemBuilder: (BuildContext ctx, index) {
                return GridItem(
                    item: selectedList[index],
                    isSelected: (bool value) {
                      // setState(() {
                      //   if (value) {
                      //     selectedList.add(itemList[index]);
                      //   } else {
                      //     selectedList.remove(itemList[index]);
                      //   }
                      // });
                    },
                    key: Key(widget.domainsGridList[index]['extension']));
              }),
        ),
        SizedBox(height: Dimens.paddingMedium),
      ],
    );
  }
}
