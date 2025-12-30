import 'package:get/get.dart';
import 'package:passageiro/features/auth/domain/models/error_response.dart';
import 'package:passageiro/features/auth/screens/sign_in_screen.dart';
import 'package:passageiro/features/splash/controllers/config_controller.dart';
import 'package:passageiro/helper/display_helper.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if(response.statusCode == 401) {
      Get.find<ConfigController>().removeSharedData();
      Get.offAll(()=> const SignInScreen());

    }else if(response.statusCode == 403) {
      ErrorResponse errorResponse;
      errorResponse = ErrorResponse.fromJson(response.body);
      if(errorResponse.errors != null && errorResponse.errors!.isNotEmpty){
        showCustomSnackBar(errorResponse.errors![0].message!);
      }else{
        showCustomSnackBar(response.body['message']);
      }

    }else if(response.statusCode == 422) {
      ErrorResponse errorResponse;
      errorResponse = ErrorResponse.fromJson(response.body);
      if(errorResponse.errors != null && errorResponse.errors!.isNotEmpty){
        showCustomSnackBar(errorResponse.errors![0].message!);
      }else{
        showCustomSnackBar(response.body['message']);
      }

    }else if(response.statusCode == 500){
      showCustomSnackBar(response.statusText!);
    }else {
      showCustomSnackBar(response.statusText!);
    }
  }
}
