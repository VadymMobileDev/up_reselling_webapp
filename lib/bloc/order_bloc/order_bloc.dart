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
      yield* loadOrderToState();
    }
  }

  Stream<OrderState> loadOrderToState() async* {
    try {
      yield LoadingOrder();
      var orderParent = await repository.getOrderNumber("unstoppabledomains", "nischal@unstoppabledomains.com", "449652");

      if (orderParent.order.orderNumber == 0) {
        yield NoDataOrder("Data Not Found");
      } else {
        yield HasDataOrder(orderParent.order);
      }
    } on DioError {}
  }
}