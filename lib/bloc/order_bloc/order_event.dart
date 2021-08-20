import 'package:equatable/equatable.dart';

abstract class OrderEvent extends Equatable {
  final String email;
  final String orderNumber;
  const OrderEvent(this.email, this.orderNumber);

  @override
  List<Object> get props => [email, orderNumber];
}

class LoadOrder extends OrderEvent {
  LoadOrder(String email, String orderNumber) : super(email, orderNumber);
}
