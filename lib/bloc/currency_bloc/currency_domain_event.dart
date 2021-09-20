import 'package:equatable/equatable.dart';

abstract class CurrencyDomainEvent extends Equatable {
  final String keyHeader;
  final String apiHeader;
  final String currency;

  const CurrencyDomainEvent(this.keyHeader, this.apiHeader, this.currency);

  @override
  List<Object> get props => [keyHeader, apiHeader, currency];
}

class LoadCurrencyDomain extends CurrencyDomainEvent {
  LoadCurrencyDomain(String keyHeader, String apiHeader, String currency) : super(keyHeader, apiHeader, currency);
}