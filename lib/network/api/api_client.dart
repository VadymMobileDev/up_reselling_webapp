import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:up_reselling_webapp/models/domain_check.dart';
import 'package:up_reselling_webapp/models/domain_name.dart';
import 'package:up_reselling_webapp/models/order.dart';

import 'apis.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: Api.baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET(Api.domainName)
  Future<DomainResponseData> getDomainNameList(@Query("domains") String domains);

  @POST(Api.ordersNumber)
  Future<Order> sendOrderNumber();

  @GET(Api.pollStatus)
  Future<OrderParent> getOrderNumber(@Path("resellerID") String resellerID,
      @Path("email") String email, @Path("orderNumber") String orderNumber);

  @GET(Api.checkDomain)
  Future<DomainCheck> getCheckDomain(
      @Path("resellerID") String resellerID, @Path("domainName") String domainName);
}
