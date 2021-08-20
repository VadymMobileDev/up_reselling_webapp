import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:up_reselling_webapp/application/app_color.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';
import 'package:up_reselling_webapp/bloc/order_bloc/order_bloc.dart';
import 'package:up_reselling_webapp/bloc/order_bloc/order_event.dart';
import 'package:up_reselling_webapp/bloc/order_bloc/order_state.dart';
import 'package:up_reselling_webapp/bloc/send_order_number/send_order_bloc.dart';
import 'package:up_reselling_webapp/bloc/send_order_number/send_order_event.dart';
import 'package:up_reselling_webapp/bloc/send_order_number/send_order_state.dart';
import 'package:up_reselling_webapp/models/domains_list.dart';

class CheckAndPayPage extends StatefulWidget {
  final List<DomainItemCart> selectedDomainItems;
  final bool showHidePay;
  final String userEmail;

  CheckAndPayPage(
      {Key? key,
      required this.selectedDomainItems,
      required this.showHidePay,
      required this.userEmail})
      : super(key: key);

  @override
  CheckAndPayPageState createState() => CheckAndPayPageState();
}

class CheckAndPayPageState extends State<CheckAndPayPage> {
  int orderNumber = 0;

  @override
  Widget build(BuildContext context) => BlocListener<SendOrderBloc, SendOrderState>(
      listener: (context, state) {
        if (state is HasDataSendOrder) {
          context
              .read<OrderBloc>()
              .add(LoadOrder(widget.userEmail, "${state.result.order.orderNumber}"));
        }
      },
      child: Visibility(
          visible: !widget.showHidePay,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: Dimens.paddingMediumLarge),
            Text("You are about to pay \$${priceSum(widget.selectedDomainItems)}",
                style: TextStyle(
                    fontSize: Dimens.paddingXSLarge,
                    color: AppColor.black,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: Dimens.paddingTenFount),
            Text("for ${widget.selectedDomainItems.length}x domains ",
                style: TextStyle(color: AppColor.black)),
            SizedBox(height: Dimens.paddingLarge),
            ElevatedButton(
                onPressed: () {
                  context.read<SendOrderBloc>().add(LoadSendOrder(
                      widget.userEmail, "${widget.selectedDomainItems[0].nameDomain}"));
                },
                child: Text("Pay"),
                style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    primary: AppColor.primaryBlue,
                    minimumSize: Size(double.infinity, Dimens.margeButtonEdge),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Dimens.paddingDefault)))),
            SizedBox(height: Dimens.paddingMediumLarge),
            BlocListener<OrderBloc, OrderState>(
              listener: (context, state) {
                if (state is HasDataOrder) {
                  setState(() {
                    orderNumber = state.result.orderNumber!;
                  });
                }
              },
              child: (orderNumber != 0)
                  ? Text("Response received successfully, order number is: $orderNumber")
                  : Text(""),
            )
          ])));

  int priceSum(List<DomainItemCart> selectedDomainItems) {
    int sum = 0;
    selectedDomainItems.forEach((element) {
      sum += element.domainItem!.price ~/ 100;
    });
    return sum;
  }
}
