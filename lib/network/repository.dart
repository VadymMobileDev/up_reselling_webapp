import 'package:up_reselling_webapp/models/currency_domain.dart';
import 'package:up_reselling_webapp/models/domain_check.dart';
import 'package:up_reselling_webapp/models/order.dart';
import 'package:up_reselling_webapp/models/order_send.dart';

abstract class Repository {
  Future<String> getDomainNameList(String domains);
  Future<OrderSend> sendOrderNumber(String resellerID, String email, String json);
  Future<OrderParent> getOrderNumber(String resellerID, String email, String orderNumber);
  Future<DomainCheck> getCheckDomain(String resellerID, String domainName);

  Future<CurrencyDomain> getRatesCurrency(String keyHeader, String apiHeader, String currency);
}
