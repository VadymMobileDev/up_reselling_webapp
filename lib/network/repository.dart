import 'package:up_reselling_webapp/models/domain_name.dart';
import 'package:up_reselling_webapp/models/order.dart';

abstract class Repository {
  Future<DomainResponseData> getDomainNameList();
  Future<Order> sendOrderNumber();
  Future<OrderParent> getOrderNumber(String resellerID, String email, String orderNumber);
}
