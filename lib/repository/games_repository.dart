import 'package:up_reselling_webapp/models/domain_name.dart';
import 'package:up_reselling_webapp/models/order.dart';
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
  Future<DomainResponseData> getDomainNameList() async {
    return await apiRepository.getDomainNameList();
  }

  @override
  Future<OrderParent> getOrderNumber(String resellerID, String email, String orderNumber) async {
    return await apiRepository.getOrderNumber(resellerID, email, orderNumber);
  }

  @override
  Future<Order> sendOrderNumber() {
    // TODO: implement sendOrderNumber
    throw UnimplementedError();
  }
}
