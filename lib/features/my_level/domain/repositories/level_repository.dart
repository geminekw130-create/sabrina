import 'package:get/get_connect/http/src/response/response.dart';
import 'package:passageiro/data/api_client.dart';
import 'package:passageiro/features/my_level/domain/repositories/level_repository_interface.dart';
import 'package:passageiro/util/app_constants.dart';

class LevelRepository implements LevelRepositoryInterface{
  ApiClient apiClient;
  LevelRepository({required this.apiClient});

  @override
  Future<Response> getProfileLevelInfo() async{
    return apiClient.getData(AppConstants.getProfileLevel);
  }

}