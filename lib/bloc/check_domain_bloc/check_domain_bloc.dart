import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:up_reselling_webapp/network/repository.dart';

import 'bloc.dart';

class CheckDomainBloc extends Bloc<CheckDomainEvent, CheckDomainState> {
  final Repository repository;

  CheckDomainBloc({required this.repository}) : super(InitialCheckDomain());

  @override
  Stream<CheckDomainState> mapEventToState(CheckDomainEvent event) async* {
    if (event is LoadCheckDomain) {
      yield* loadCheckDomainToState(event.resellerID, event.domainName);
    }
  }

  Stream<CheckDomainState> loadCheckDomainToState(String resellerID, String domainName) async* {
    try {
      yield LoadingCheckDomain();
      var checkDomain = await repository.getCheckDomain(resellerID, domainName);

      if (checkDomain.domain.name!.isEmpty) {
        yield NoDataCheckDomain("Data Not Found");
      } else {
        yield HasDataCheckDomain(checkDomain);
      }
    } on DioError {}
  }
}
