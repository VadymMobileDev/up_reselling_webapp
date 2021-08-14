import 'package:equatable/equatable.dart';

abstract class DomainChooseState extends Equatable {
  const DomainChooseState();

  @override
  List<Object> get props => [];
}

class Initial extends DomainChooseState {}

class Loading extends DomainChooseState {}

class HasData extends DomainChooseState {
  final String result;

  const HasData(this.result);

  @override
  List<Object> get props {
    return[result];
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
