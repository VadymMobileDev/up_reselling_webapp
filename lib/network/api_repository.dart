import 'package:dio/dio.dart';
import 'package:up_reselling_webapp/models/domain_check.dart';
import 'package:up_reselling_webapp/models/order.dart';
import 'package:up_reselling_webapp/models/order_send.dart';
import 'package:up_reselling_webapp/network/api/api_client.dart';
import 'package:up_reselling_webapp/network/repository.dart';


class ApiRepository implements Repository {
  Dio _dio = Dio(BaseOptions(contentType: "application/json"));
  late RestClient _restClient = RestClient(_dio);


  @override
  Future<String> getDomainNameList(String domains) {
    return _restClient.getDomainNameList("[\""+domains+"\"]");
  }
  @override
  Future<OrderParent> getOrderNumber(String resellerID, String email, String orderNumber) {
    return _restClient.getOrderNumber(resellerID, email, orderNumber);
  }

  @override
  Future<OrderSend> sendOrderNumber(String resellerID, String email, String json) {
    return _restClient.sendOrderNumber(resellerID, email, json);
  }

  @override
  Future<DomainCheck> getCheckDomain(String resellerID, String domainName) {
    return _restClient.getCheckDomain(resellerID, domainName);
  }
}