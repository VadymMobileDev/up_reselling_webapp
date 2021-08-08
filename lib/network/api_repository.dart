import 'package:dio/dio.dart';
import 'package:up_reselling_webapp/models/data.dart';
import 'package:up_reselling_webapp/models/domain_name.dart';
import 'package:up_reselling_webapp/network/api/api_client.dart';
import 'package:up_reselling_webapp/network/repository.dart';
import 'package:up_reselling_webapp/utils/logging_interceptor.dart';


class ApiRepository implements Repository2 {
  late Dio _dio;
  late RestClient _restClient;

  ApiRepository() {
    _dio = Dio();
    _dio.interceptors.add(LoggingInterceptors());
   _restClient = RestClient(_dio);
  }

  @override
  Future<ResponseData> getUsers() {
    return _restClient.getUsers();
  }

  @override
  Future<DomainResponseData> getDomainNameList() {
    return _restClient.getDomainNameList("[\"crypto\"]");
  }
}