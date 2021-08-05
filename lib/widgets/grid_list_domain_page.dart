import 'package:flutter/material.dart';
import 'package:up_reselling_webapp/models/grid_domain.dart';
import 'grid_item_form.dart';

class GridListDomainPage extends StatefulWidget {
  GridListDomainPage({Key? key}) : super(key: key);

  @override
  _GridListDomainState createState() => _GridListDomainState();
}

class _GridListDomainState extends State<GridListDomainPage> {
  late List<DomainGrid> itemList = [
    DomainGrid(".x", "100"),
    DomainGrid(".crypto", "40"),
    DomainGrid(".coin", "20"),
    DomainGrid(".wallet", "40"),
    DomainGrid(".bitcoin", "20"),
    DomainGrid(".888", "20"),
    DomainGrid(".nft", "20"),
    DomainGrid(".dao", "20"),
    DomainGrid(".zil", "20"),
  ];

  late List<DomainGrid> selectedList = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemCount: itemList.length,
              itemBuilder: (BuildContext ctx, index) {
                return GridItem(
                    item: itemList[index],
                    isSelected: (bool value) {
                      setState(() {
                        if (value) {
                          selectedList.add(itemList[index]);
                        } else {
                          selectedList.remove(itemList[index]);
                        }
                      });
                      print("$index : $value    ==== ${selectedList.length}");
                    },
                    key: Key(itemList[index].domainName));
              }),

        ),

          Container(
          width: MediaQuery.of(context).size.width,
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
                      key: Key(itemList[index].domainName));
                }),
)

      ],
    );
  }
}