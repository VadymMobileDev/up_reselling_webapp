import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:up_reselling_webapp/network/repository.dart';

import 'bloc.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final Repository repository;

  OrderBloc({required this.repository}) : super(InitialOrder());

  @override
  Stream<OrderState> mapEventToState(OrderEvent event) async* {
    if (event is LoadOrder) {
      yield* loadOrderToState(event.email, event.orderNumber);
    }
  }

  Stream<OrderState> loadOrderToState(String email, String orderNumber) async* {
    try {
      yield LoadingOrder();
      var orderParent = await repository.getOrderNumber("unstoppabledomains", email, orderNumber);

      if (orderParent.order.orderNumber == 0) {
        yield NoDataOrder("Data Not Found");
      } else {
        yield HasDataOrder(orderParent.order);
      }
    } on DioError {}
  }
}
