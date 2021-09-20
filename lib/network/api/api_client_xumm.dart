import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:up_reselling_webapp/models/currency_domain.dart';

import 'apis.dart';

part 'api_client_xumm.g.dart';

@RestApi(baseUrl: Api.baseUrlXumm)
abstract class RestClientXumm {
  factory RestClientXumm(Dio dio, {String baseUrl}) = _RestClientXumm;

  @GET(Api.currency)
  Future<CurrencyDomain> getRatesCurrency(@Header("X-API-Key") String? keyHeader,
      @Header("X-API-Secret") String? apiHeader, @Path("currency") String currency);
}
