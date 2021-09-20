import 'package:equatable/equatable.dart';
import 'package:up_reselling_webapp/models/currency_domain.dart';
import 'package:up_reselling_webapp/models/domain_check.dart';

abstract class CurrencyDomainState extends Equatable {
  const CurrencyDomainState();

  @override
  List<Object> get props => [];
}

class InitialCurrencyDomain extends CurrencyDomainState {}

class LoadingCurrencyDomain extends CurrencyDomainState {}

class HasDataCurrencyDomain extends CurrencyDomainState {
  final CurrencyDomain result;

  const HasDataCurrencyDomain(this.result);

  @override
  List<Object> get props {
    return[result];
  }
}

class NoDataCurrencyDomain extends CurrencyDomainState {
  final String message;

  const NoDataCurrencyDomain(this.message);

  @override
  List<Object> get props{
    return[message];
  }

}

class NoInternetCurrencyDomain extends CurrencyDomainState {}

class ErrorCurrencyDomain extends CurrencyDomainState {
  final String errorMessage;

  const ErrorCurrencyDomain(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
