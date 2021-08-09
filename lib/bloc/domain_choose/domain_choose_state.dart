import 'package:equatable/equatable.dart';
import 'package:up_reselling_webapp/models/domain_name.dart';

abstract class DomainChooseState extends Equatable {
  const DomainChooseState();

  @override
  List<Object> get props => [];
}

class Initial extends DomainChooseState {}

class Loading extends DomainChooseState {}

class HasData extends DomainChooseState {
  final DomainResponseData result;

  const HasData(this.result);

  @override
  List<Object> get props {
    return[result.crypto];
  }
}

class NoData extends DomainChooseState {
  final String message;

  const NoData(this.message);

  @override
  List<Object> get props{
    return[message];
  }

}

class NoInternet extends DomainChooseState {}

class Error extends DomainChooseState {
  final String errorMessage;

  const Error(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
