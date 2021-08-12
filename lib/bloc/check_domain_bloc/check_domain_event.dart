import 'package:equatable/equatable.dart';

abstract class CheckDomainEvent extends Equatable {
  final String resellerID;
  final String domainName;

  const CheckDomainEvent(this.resellerID, this.domainName);

  @override
  List<Object> get props => [resellerID, domainName];
}

class LoadCheckDomain extends CheckDomainEvent {
  LoadCheckDomain(String resellerID, String domainName) : super(resellerID, domainName);
}
