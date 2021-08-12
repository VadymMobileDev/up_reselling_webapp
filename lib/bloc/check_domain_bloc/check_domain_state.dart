import 'package:equatable/equatable.dart';
import 'package:up_reselling_webapp/models/domain_check.dart';

abstract class CheckDomainState extends Equatable {
  const CheckDomainState();

  @override
  List<Object> get props => [];
}

class InitialCheckDomain extends CheckDomainState {}

class LoadingCheckDomain extends CheckDomainState {}

class HasDataCheckDomain extends CheckDomainState {
  final DomainCheck result;

  const HasDataCheckDomain(this.result);

  @override
  List<Object> get props {
    return[result];
  }
}

class NoDataCheckDomain extends CheckDomainState {
  final String message;

  const NoDataCheckDomain(this.message);

  @override
  List<Object> get props{
    return[message];
  }

}

class NoInternetCheckDomain extends CheckDomainState {}

class ErrorCheckDomain extends CheckDomainState {
  final String errorMessage;

  const ErrorCheckDomain(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
