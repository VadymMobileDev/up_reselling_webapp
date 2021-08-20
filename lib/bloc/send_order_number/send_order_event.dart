import 'package:equatable/equatable.dart';

abstract class SendOrderEvent extends Equatable {
  final String email;
  final String domainName;

  const SendOrderEvent(this.email, this.domainName);

  @override
  List<Object> get props => [email, domainName];
}

class LoadSendOrder extends SendOrderEvent {
  LoadSendOrder(String email, String domainName) : super(email, domainName);
}
