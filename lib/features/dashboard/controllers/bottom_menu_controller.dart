import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:passageiro/common_widgets/confirmation_bottomsheet_widget.dart';
import 'package:passageiro/features/dashboard/screens/dashboard_screen.dart';
import 'package:passageiro/util/images.dart';
import 'package:passageiro/features/location/controllers/location_controller.dart';
import 'package:passageiro/features/location/view/access_location_screen.dart';

class BottomMenuController extends GetxController implements GetxService{

  int _currentTab = 0;
  int get currentTab => _currentTab;

  void resetNavBar() {
    _currentTab = 0;
  }

  void setTabIndex(int index) {
    _currentTab = index;
     update();
  }

  void navigateToDashboard() {
    _currentTab = 0;
    if(Get.find<LocationController>().getUserAddress() != null) {
      Get.offAll(()=> const DashboardScreen());
    }else {
      Get.offAll(const AccessLocationScreen());
    }
  }

  void exitApp() {
    Get.bottomSheet(ConfirmationBottomsheetWidget(
      icon: Images.exitIcon,
      title: 'exit_app'.tr,
      description: 'do_you_want_to_exit_the_app'.tr,
      onYesPressed: ()=> SystemNavigator.pop(),
      onNoPressed: ()=> Get.back(),
    ));
  }

}
