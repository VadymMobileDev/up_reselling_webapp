import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:up_reselling_webapp/application/app_color.dart';
import 'package:up_reselling_webapp/application/app_text.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';
import 'package:up_reselling_webapp/bloc/check_domain_bloc/check_domain_bloc.dart';
import 'package:up_reselling_webapp/bloc/check_domain_bloc/check_domain_event.dart';
import 'package:up_reselling_webapp/bloc/check_domain_bloc/check_domain_state.dart';
import 'package:up_reselling_webapp/models/domain_check.dart';

import '../blockchain_domain_page/blockchain_domain_page.dart';

const resellerID = "unstoppabledomains";

class CheckDomainPage extends StatefulWidget {
  final bool enabled;
  final Domain domain;
  final CheckDomainCallback domainCallback;

  CheckDomainPage({
    Key? key,
    required this.enabled,
    required this.domain,
    required this.domainCallback,
  }) : super(key: key);

  @override
  CheckDomainPageState createState() => CheckDomainPageState();
}

class CheckDomainPageState extends State<CheckDomainPage> {
  //late String dropdownValue = widget.enabled ? AppText.spinnerItems[0] : widget.domainEnabled;
  late String dropdownValue = AppText.spinnerItems[0];

  TextEditingController domainController = TextEditingController();

  @override
  Widget build(BuildContext context) => BlocListener<CheckDomainBloc, CheckDomainState>(
      listener: (context, state) {
        if (state is HasDataCheckDomain) {
          print("--------- state.result.domain ${state.result.domain}");

          if (domainController.text.isNotEmpty) {
              widget.domainCallback(state.result.domain);
            }
          } else {
            Text(AppText.x_try_another_domain);
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
                          //enabled: widget.enabled ? true : false,
                          maxLength: 40,
                          controller: domainController,
                          //widget.enabled ? domainController : domainController = TextEditingController(text: widget.nameEnabled),
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
                    onChanged:
                        //widget.enabled ?
                        (String? data) {
                      setState(() {
                        dropdownValue = data!;
                      });
                    },
                    // : null,
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

              print("--------- ElevatedButton ${domainController.text}$dropdownValue");
              context
                  .read<CheckDomainBloc>()
                  .add(LoadCheckDomain(resellerID, "${domainController.text}$dropdownValue"));
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
