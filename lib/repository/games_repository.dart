import 'package:up_reselling_webapp/models/data.dart';
import 'package:up_reselling_webapp/models/domain_name.dart';
import 'package:up_reselling_webapp/network/api_repository.dart';
import 'package:up_reselling_webapp/network/repository.dart';

class GamesRepository implements Repository2 {
  final ApiRepository apiRepository;

  static final GamesRepository _singleton =
      GamesRepository._internal(apiRepository: ApiRepository());

  factory GamesRepository() {
    return _singleton;
  }

  GamesRepository._internal({required this.apiRepository});


  @override
  Future<ResponseData> getUsers() async {
    return await apiRepository.getUsers();
  }

  @override
  Future<DomainResponseData> getDomainNameList() async {
    return await apiRepository.getDomainNameList();
  }

}
