import 'package:up_reselling_webapp/models/domain_check.dart';
import 'package:up_reselling_webapp/models/order.dart';

abstract class Repository {
  Future<String> getDomainNameList(String domains);
  Future<Order> sendOrderNumber();
  Future<OrderParent> getOrderNumber(String resellerID, String email, String orderNumber);
  Future<DomainCheck> getCheckDomain(String resellerID, String domainName);
}
