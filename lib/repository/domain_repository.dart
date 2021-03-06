import 'package:up_reselling_webapp/models/currency_domain.dart';
import 'package:up_reselling_webapp/models/domain_check.dart';
import 'package:up_reselling_webapp/models/order.dart';
import 'package:up_reselling_webapp/models/order_send.dart';
import 'package:up_reselling_webapp/network/api_repository.dart';
import 'package:up_reselling_webapp/network/repository.dart';

class DomainRepository implements Repository {
  final ApiRepository apiRepository;

  static final DomainRepository _singleton =
      DomainRepository._internal(apiRepository: ApiRepository());

  factory DomainRepository() {
    return _singleton;
  }

  DomainRepository._internal({required this.apiRepository});

  @override
  Future<String> getDomainNameList(String domains) async {
    return await apiRepository.getDomainNameList(domains);
  }

  @override
  Future<OrderParent> getOrderNumber(String resellerID, String email, String orderNumber) async {
    return await apiRepository.getOrderNumber(resellerID, email, orderNumber);
  }

  @override
  Future<DomainCheck> getCheckDomain(String resellerID, String domainName) async {
    return await apiRepository.getCheckDomain(resellerID, domainName);
  }

  @override
  Future<OrderSend> sendOrderNumber(String resellerID, String email, String json) async {
    return await apiRepository.sendOrderNumber(resellerID, email, json);
  }

  @override
  Future<CurrencyDomain> getRatesCurrency(String keyHeader, String apiHeader, String currency) async {
    return await apiRepository.getRatesCurrency(keyHeader, apiHeader, currency);
  }
}
