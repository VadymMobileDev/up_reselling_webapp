import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:up_reselling_webapp/models/data.dart';
import 'package:up_reselling_webapp/models/domain_name.dart';

import 'apis.dart';

// part 'api_client.g.dart';

//@RestApi(baseUrl: "https://gorest.co.in/public-api/")
@RestApi(baseUrl: Api.baseUrl)
abstract class RestClient {
  //factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  // @GET("/users")
  // Future<ResponseData> getUsers();
  //
  // @GET("/myetherwallet/domains/variations?")
  // Future<DomainResponseData> getDomainNameList(@Query("domains") String domains);
}
