import 'package:up_reselling_webapp/models/data.dart';
import 'package:up_reselling_webapp/models/domain_name.dart';

abstract class Repository2 {
  Future<ResponseData> getUsers();
  Future<DomainResponseData> getDomainNameList();
}
