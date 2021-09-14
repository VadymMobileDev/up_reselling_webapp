import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:up_reselling_webapp/network/repository.dart';

import 'bloc.dart';

class DomainChooseBloc extends Bloc<DomainChooseEvent, DomainChooseState> {
  final Repository repository;

  DomainChooseBloc({required this.repository}) : super(Initial());

  @override
  Stream<DomainChooseState> mapEventToState(DomainChooseEvent event) async* {
    if (event is LoadDomains) {
      yield* loadDomainsListToState(event.domains);
    }
  }

  Stream<DomainChooseState> loadDomainsListToState(String domains) async* {
    try {
      yield Loading();
      var domain = await repository.getDomainNameList(domains);

      if (domain.isEmpty) {
        yield NoData("Domain Choose Found");
      } else {
        yield HasData(domain);
      }
    } on DioError {}
  }
}
