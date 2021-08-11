import 'package:equatable/equatable.dart';

abstract class DomainChooseEvent extends Equatable {
  final String domains;
  const DomainChooseEvent(this.domains);

  @override
  List<Object> get props => [domains];
}

class LoadDomains extends DomainChooseEvent {
  LoadDomains(String domains) : super(domains);
}
