import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:up_reselling_webapp/application/app_color.dart';
import 'package:up_reselling_webapp/application/style/dimens.dart';
import 'package:up_reselling_webapp/bloc/order_bloc/bloc.dart';
import 'package:up_reselling_webapp/bloc/order_bloc/order_bloc.dart';
import 'package:up_reselling_webapp/bloc/order_bloc/order_state.dart';
import 'package:up_reselling_webapp/bloc/send_order_number/send_order_bloc.dart';
import 'package:up_reselling_webapp/bloc/send_order_number/send_order_event.dart';
import 'package:up_reselling_webapp/bloc/send_order_number/send_order_state.dart';
import 'package:up_reselling_webapp/models/domains_list.dart';
import 'package:up_reselling_webapp/widgets/payment/payment_page.dart';

class CheckAndPayPage extends StatefulWidget {
  final List<DomainItemCart> selectedDomainItems;
  final bool showHidePay;
  final String userEmail;
  final ShowSuccessPayCallback callbackSuccessPay;

  CheckAndPayPage(
      {Key? key, required this.callbackSuccessPay,
      required this.selectedDomainItems,
      required this.showHidePay,
      required this.userEmail})
      : super(key: key);

  @override
  CheckAndPayPageState createState() => CheckAndPayPageState();
}

class CheckAndPayPageState extends State<CheckAndPayPage> {
  int orderNumber = 0;
  List<int?> orders = [];
  var orderPrice = 0;
  @override
  Widget build(BuildContext context) => BlocListener<SendOrderBloc, SendOrderState>(
      listener: (context, state) {
        if (state is HasDataSendOrder) {
          orders.add(state.result.order.orderNumber);
          orderPrice += state.result.order.subtotal!;
        if(orders.length == widget.selectedDomainItems.length){
            orders.forEach((element) {
              context.read<OrderBloc>().add(LoadOrder(widget.userEmail, "$element"));
            });
          }
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

                  widget.selectedDomainItems.forEach((element) {
                    context.read<SendOrderBloc>().add(LoadSendOrder(
                        widget.userEmail, "${element.domainItem?.label}.${element.domainItem?.extension}"));

                  });


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
                    widget.callbackSuccessPay(true, orderPrice);
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
