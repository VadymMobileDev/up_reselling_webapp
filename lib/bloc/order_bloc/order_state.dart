import 'package:equatable/equatable.dart';
import 'package:up_reselling_webapp/models/order.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class InitialOrder extends OrderState {}

class LoadingOrder extends OrderState {}

class HasDataOrder extends OrderState {
  final Order result;

  const HasDataOrder(this.result);

  @override
  List<Object> get props {
    return[result];
  }
}

class NoDataOrder extends OrderState {
  final String message;

  const NoDataOrder(this.message);

  @override
  List<Object> get props{
    return[message];
  }

}

class NoInternetOrder extends OrderState {}

class ErrorOrder extends OrderState {
  final String errorMessage;

  const ErrorOrder(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
