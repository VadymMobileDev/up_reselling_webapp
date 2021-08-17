import 'package:equatable/equatable.dart';
import 'package:up_reselling_webapp/models/order_send.dart';

abstract class SendOrderState extends Equatable {
  const SendOrderState();

  @override
  List<Object> get props => [];
}

class InitialSendOrder extends SendOrderState {}

class LoadingSendOrder extends SendOrderState {}

class HasDataSendOrder extends SendOrderState {
  final OrderSend result;

  const HasDataSendOrder(this.result);

  @override
  List<Object> get props {
    return[result];
  }
}

class NoDataSendOrder extends SendOrderState {
  final String message;

  const NoDataSendOrder(this.message);

  @override
  List<Object> get props{
    return[message];
  }

}

class NoInternetSendOrder extends SendOrderState {}

class ErrorSendOrder extends SendOrderState {
  final String errorMessage;

  const ErrorSendOrder(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
