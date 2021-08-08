import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:up_reselling_webapp/network/api/api_client.dart';
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
      print("---------- event");
      yield* mapLoadGamesToState();
     }
  }
  //
  Stream<GamesState> mapLoadGamesToState() async* {
    final client = RestClient(Dio(BaseOptions(contentType: "application/json")));
    client.getDomainNameList("[\"crypto\"]");
    try {
      yield GamesLoading();
      var games = await client.getDomainNameList("[\"crypto\"]");

      if (games.crypto.isEmpty) {
        yield GamesNoData("Games Not Found");
      } else {
        yield GamesHasData(games);
      }
    } on DioError catch (e) {
      print("---------  e $e");
    }
  }

  // FutureBuilder<DomainResponseData> buildBody(BuildContext context) {
  //   final client = RestClient(Dio(BaseOptions(contentType: "application/json")));
  //   return FutureBuilder<DomainResponseData>(
  //     future: client.getDomainNameList("[\"crypto\"]"),
  //     builder: (context, snapshot) {
  //       if (snapshot.hasError) {}
  //       if (snapshot.connectionState == ConnectionState.done) {
  //         final posts = snapshot.data;
  //
  //         return GamesHasData(posts)
  //       } else {
  //         return Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       }
  //     },
  //   );
  // }
  //

}
