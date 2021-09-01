import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:up_reselling_webapp/application/app_color.dart';
import 'package:up_reselling_webapp/application/app_text.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';
import 'package:up_reselling_webapp/bloc/check_domain_bloc/check_domain_bloc.dart';
import 'package:up_reselling_webapp/bloc/check_domain_bloc/check_domain_event.dart';
import 'package:up_reselling_webapp/bloc/check_domain_bloc/check_domain_state.dart';

import '../blockchain_domain_page/blockchain_domain_page.dart';

const resellerID = "unstoppabledomains";

class CheckDomainPage extends StatefulWidget {
  final bool enabled;
  final String nameEnabled;
  final String domainEnabled;

  CheckDomainPage(
      {Key? key, required this.enabled, required this.nameEnabled, required this.domainEnabled})
      : super(key: key);

  @override
  CheckDomainPageState createState() => CheckDomainPageState();
}

class CheckDomainPageState extends State<CheckDomainPage> {
  late String dropdownValue = widget.enabled ? AppText.spinnerItems[0] : widget.domainEnabled;
  TextEditingController domainController = TextEditingController();

  @override
  Widget build(BuildContext context) => BlocListener<CheckDomainBloc, CheckDomainState>(
      listener: (context, state) {
        if (state is HasDataCheckDomain) {
          if (domainController.text.isNotEmpty) {
            bool resellingValidate = state.result.domain.reselling == null ? false : true;

            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BlockchainDomainPage(
                      domainName: domainController.text,
                      domainLogo: dropdownValue,
                      resellingValidate: resellingValidate,
                      spinnerItems: AppText.spinnerItems)),
            );
          } else {
            Text("Please try another domain name.");
          }
        }
      },
      child: Column(children: [
        Card(
          color: AppColor.backgroundLightGrey,
          elevation: 0.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(Dimens.paddingDefault)),
              side: BorderSide(width: 2, color: AppColor.borderCardGrey)),
          child: Padding(
            padding: EdgeInsets.all(Dimens.paddingSemi),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextField(
                          enabled: widget.enabled ? true : false,
                          maxLength: 6,
                          controller: widget.enabled
                              ? domainController
                              : domainController = TextEditingController(text: widget.nameEnabled),
                          decoration: InputDecoration(
                            counterText: '',
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            isDense: true,
                            hintText: "Domain name",
                          ),
                        ))),
                Container(height: 20, width: 2, color: AppColor.borderCardGrey),
                SizedBox(width: Dimens.paddingMedium),
                Container(
                  height: 40,
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    style: TextStyle(
                        color: AppColor.black,
                        fontSize: Dimens.paddingMedium,
                        fontWeight: FontWeight.bold),
                    icon: Icon(Icons.arrow_drop_down),
                    underline: Container(height: 0),
                    onChanged: widget.enabled
                        ? (String? data) {
                            setState(() {
                              dropdownValue = data!;
                            });
                          }
                        : null,
                    items: AppText.spinnerItems.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: Dimens.paddingMedium),
        ElevatedButton(
            onPressed: () {
              if (widget.enabled) {
                context
                    .read<CheckDomainBloc>()
                    .add(LoadCheckDomain(resellerID, "${domainController.text}$dropdownValue"));
              }
            },
            child: Text("Check Domain"),
            style: ElevatedButton.styleFrom(
                elevation: 0.0,
                primary: AppColor.primaryBlue,
                minimumSize: Size(double.infinity, Dimens.margeButtonEdge),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimens.paddingDefault)))),
        SizedBox(height: Dimens.paddingMediumLarge),
      ]));
}
