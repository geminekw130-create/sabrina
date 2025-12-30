import 'package:get/get_connect/http/src/response/response.dart';
import 'package:passageiro/data/api_client.dart';
import 'package:passageiro/util/app_constants.dart';


class CategoryRepo{
  final ApiClient apiClient;

  CategoryRepo({required this.apiClient});

  Future<Response?> getCategoryList() async {
    return await apiClient.getData(AppConstants.vehicleMainCategory);
  }

}