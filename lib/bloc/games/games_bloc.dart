import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:up_reselling_webapp/network/repository.dart';

import 'bloc.dart';

class GamesBloc extends Bloc<GamesEvent, GamesState> {
  final Repository2 repository;

  GamesBloc({required this.repository}) : super(InitialGames());

  @override
  Stream<GamesState> mapEventToState(
    GamesEvent event,
  ) async* {
    if (event is LoadGames) {
      //yield* _mapLoadGamesToState();
    }
  }
  //
  // Stream<GamesState> _mapLoadGamesToState() async* {
  //   try {
  //     yield GamesLoading();
  //     print("--------- ");
  //     var games = await repository.getUsers();
  //
  //     print("--------- ${games}");
  //     if (games.data.isEmpty) {
  //       yield GamesNoData("Games Not Found");
  //       print("--------- Games Not Found");
  //
  //     } else {
  //
  //       yield GamesHasData(games);
  //       print("--------- ${games}");
  //     }
  //   } on DioError catch (e) {
  //
  //     print("--------- error ${e}");
  //   }
  // }
}
