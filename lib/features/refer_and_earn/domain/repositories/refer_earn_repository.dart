
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:passageiro/data/api_client.dart';
import 'package:passageiro/features/refer_and_earn/domain/repositories/refer_earn_repository_interface.dart';
import 'package:passageiro/util/app_constants.dart';

class ReferEarnRepository implements ReferEarnRepositoryInterface{
  final ApiClient apiClient;
  ReferEarnRepository({required this.apiClient});

  @override
  Future<Response> getEarningHistoryList(int offset) async{
    return await apiClient.getData('${AppConstants.referralEarningList}$offset');
  }

  @override
  Future<Response> getReferralDetails() async{
   return await apiClient.getData(AppConstants.referralDetails);
  }
}