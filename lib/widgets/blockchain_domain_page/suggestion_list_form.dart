import 'package:flutter/material.dart';
import 'package:up_reselling_webapp/application/app_color.dart';
import 'package:up_reselling_webapp/application/app_text.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';
import 'package:up_reselling_webapp/models/domains_list.dart';
import 'package:up_reselling_webapp/widgets/grid_list/grid_list_domain_page.dart';

import '../general/widgets_repository.dart';

class SuggestionListForm extends StatefulWidget {
  final bool resellingValidate;
  final List<DomainItem> listDomainSuggestion;
  final String domainsLogoSelected;

  final SuggestionDomainListCallback domainItemCart;
  final SuggestionShowCartCallback callbackShow;
  final SuggestionGridShowCartCallback stateGrid;
  final SuggestionGridRemoveCallback remove;

  SuggestionListForm({
    Key? key,
    required this.resellingValidate,
    required this.listDomainSuggestion,
    required this.domainsLogoSelected,
    required this.domainItemCart,
    required this.callbackShow,
    required this.stateGrid,
    required this.remove,
  }) : super(key: key);

  @override
  _SuggestionListFormState createState() => _SuggestionListFormState();
}

class _SuggestionListFormState extends State<SuggestionListForm> {
  late List<DomainItemCart> selectedDomainItemCart = [];

  @override
  Widget build(BuildContext context) => Visibility(
        visible: widget.resellingValidate ? false : true,
        child: Column(
          children: [
            SizedBox(height: Dimens.paddingMedium),
            TextBold(
                text: AppText.grid_looking_for,
                fontSize: Dimens.defaultFountSize,
                color: AppColor.textBlue),
            Container(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.listDomainSuggestion.length,
                itemBuilder: (context, index) {
                  final item = widget.listDomainSuggestion[index];
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
                            child: TextBold(
                                text: "\$${item.price ~/ 100}.00",
                                fontSize: Dimens.paddingSemi,
                                color: AppColor.textBlue)),
                        Expanded(
                          child: Align(
                              alignment: Alignment.center,
                              child: ElevatedButton.icon(
                                icon: Icon(Icons.add_shopping_cart,
                                    color: AppColor.white, size: Dimens.paddingMedium),
                                onPressed: () {

                                  DomainItemCart addedDomain = DomainItemCart(
                                      nameDomain: widget.domainsLogoSelected, domainItem: item);
                                    selectedDomainItemCart.add(addedDomain);
                                    widget.domainItemCart(addedDomain);
                                    setState(() {
                                      widget.callbackShow(true);
                                      widget.stateGrid(false);
                                      widget.remove(index);
                                    });
                                },
                                label: Text(AppText.btn_add_to_cart,
                                    style: TextStyle(fontSize: Dimens.paddingSemi)),
                                style: ElevatedButton.styleFrom(
                                    primary: AppColor.primaryBlue,
                                    minimumSize: Size(double.minPositive, Dimens.paddingLarge),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(Dimens.paddingSmall))),
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
      );
}
