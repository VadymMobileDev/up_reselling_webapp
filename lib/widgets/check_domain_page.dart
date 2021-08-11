import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:up_reselling_webapp/application/app_color.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';
import 'package:up_reselling_webapp/bloc/domain_choose/bloc.dart';

import 'blockchain_domain_page/blockchain_domain_page.dart';

class CheckDomainPage extends StatefulWidget {

  final bool enabled;

  CheckDomainPage({Key? key, required this.enabled}) : super(key: key);

  @override
  CheckDomainState createState() => CheckDomainState();
}

class CheckDomainState extends State<CheckDomainPage> {
  List<String> spinnerItems = ['.crypto', '.x', '.coin', '.wallet', '.bitcoin'];
  late String dropdownValue = spinnerItems[0];
  TextEditingController domainController = TextEditingController();
  late List listDomain;

  @override
  Widget build(BuildContext context) {
    context.read<DomainChooseBloc>().add(LoadDomains("crypto"));
    return Column(children: [
      Container(child: BlocBuilder<DomainChooseBloc, DomainChooseState>(builder: (_, state) {
        if (state is HasData) {
          listDomain = state.result.crypto.toList();
          return Text("data  ${state.result}");
        } else {
          return CircularProgressIndicator();
        }
      })),
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
                        controller: domainController,
                        decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          // add padding to adjust text
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
                  onChanged: widget.enabled ? (String? data) {
                    setState(() {
                      dropdownValue = data!;
                    });
                  }: null,
                  items: spinnerItems.map<DropdownMenuItem<String>>((String value) {
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
            if (domainController.text.isNotEmpty) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlockchainDomainPage(
                          domainName: domainController.text,
                          domainLogo: dropdownValue,
                          domainsList: listDomain,
                        )),
              );
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
    ]);
  }
}
