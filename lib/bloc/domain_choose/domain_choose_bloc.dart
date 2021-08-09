import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:up_reselling_webapp/network/repository.dart';

import 'bloc.dart';

class DomainChooseBloc extends Bloc<DomainChooseEvent, DomainChooseState> {
  final Repository repository;

  DomainChooseBloc({required this.repository}) : super(Initial());

  @override
  Stream<DomainChooseState> mapEventToState(
    DomainChooseEvent event,
  ) async* {
    if (event is LoadDomains) {
      yield* loadDomainsListToState();
    }
  }

  Stream<DomainChooseState> loadDomainsListToState() async* {
    try {
      yield Loading();
      var games = await repository.getDomainNameList();

      if (games.crypto.isEmpty) {
        yield NoData("Games Not Found");
      } else {
        yield HasData(games);
      }
    } on DioError {}
  }
}
