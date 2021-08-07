import 'package:equatable/equatable.dart';
import 'package:up_reselling_webapp/models/data.dart';

abstract class GamesState extends Equatable {
  const GamesState();

  @override
  List<Object> get props => [];
}

class InitialGames extends GamesState {}

class GamesLoading extends GamesState {}

class GamesHasData extends GamesState {
  // final ResponseData result;
  //
  // const GamesHasData(this.result);
  //
  // @override
  // List<Object> get props => [result];
}

class GamesNoData extends GamesState {
  final String message;

  const GamesNoData(this.message);

  @override
  List<Object> get props => [message];
}

class GamesNoInternetConnection extends GamesState {}

class GamesError extends GamesState {
  final String errorMessage;

  const GamesError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
