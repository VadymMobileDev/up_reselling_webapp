import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:up_reselling_webapp/network/repository.dart';

import 'bloc.dart';

class CurrencyDomainBloc extends Bloc<CurrencyDomainEvent, CurrencyDomainState> {
  final Repository repository;

  CurrencyDomainBloc({required this.repository}) : super(InitialCurrencyDomain());

  @override
  Stream<CurrencyDomainState> mapEventToState(CurrencyDomainEvent event) async* {
    if (event is LoadCurrencyDomain) {
      yield* loadCurrencyDomainToState(event.keyHeader, event.apiHeader, event.currency);
    }
  }

  Stream<CurrencyDomainState> loadCurrencyDomainToState(
      String keyHeader, String apiHeader, String currency) async* {
    try {
      yield LoadingCurrencyDomain();
      var currencyDomain = await repository.getRatesCurrency(keyHeader, apiHeader, currency);
      if (currencyDomain.USD == 0) {
        yield NoDataCurrencyDomain("Data Not Found");
      } else {
        yield HasDataCurrencyDomain(currencyDomain);
      }
    } on DioError {}
  }
}
