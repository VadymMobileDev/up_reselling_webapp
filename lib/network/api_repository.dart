import 'package:dio/dio.dart';
import 'package:up_reselling_webapp/models/domain_name.dart';
import 'package:up_reselling_webapp/models/order.dart';
import 'package:up_reselling_webapp/network/api/api_client.dart';
import 'package:up_reselling_webapp/network/repository.dart';


class ApiRepository implements Repository {
  Dio _dio = Dio(BaseOptions(contentType: "application/json"));
  late RestClient _restClient = RestClient(_dio);


  @override
  Future<DomainResponseData> getDomainNameList() {
    return _restClient.getDomainNameList("[\"crypto\"]");
  }

  @override
  Future<OrderParent> getOrderNumber(String resellerID, String email, String orderNumber) {
    return _restClient.getOrderNumber(resellerID, email, orderNumber);
  }

  @override
  Future<Order> sendOrderNumber() {
    return _restClient.sendOrderNumber();
  }
}