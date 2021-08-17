import 'package:equatable/equatable.dart';

abstract class OrderEvent extends Equatable {
  final String email;
  final String domainName;
  const OrderEvent(this.email, this.domainName);

  @override
  List<Object> get props => [email, domainName];
}

class LoadOrder extends OrderEvent {
  LoadOrder(String email, String domainName) : super(email, domainName);
}
