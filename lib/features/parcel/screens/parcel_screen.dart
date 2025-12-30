import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passageiro/features/home/controllers/category_controller.dart';
import 'package:passageiro/features/map/screens/map_screen.dart';
import 'package:passageiro/features/parcel/widgets/dotted_border_card.dart';
import 'package:passageiro/features/parcel/widgets/parcel_category_screen.dart';
import 'package:passageiro/features/splash/controllers/config_controller.dart';
import 'package:passageiro/helper/display_helper.dart';
import 'package:passageiro/util/dimensions.dart';
import 'package:passageiro/features/home/widgets/banner_view.dart';
import 'package:passageiro/features/location/controllers/location_controller.dart';
import 'package:passageiro/features/map/controllers/map_controller.dart';
import 'package:passageiro/features/parcel/controllers/parcel_controller.dart';
import 'package:passageiro/features/ride/controllers/ride_controller.dart';
import 'package:passageiro/common_widgets/app_bar_widget.dart';
import 'package:passageiro/common_widgets/body_widget.dart';
import 'package:passageiro/common_widgets/button_widget.dart';

class ParcelScreen extends StatefulWidget {
  const ParcelScreen({super.key});

  @override
  State<ParcelScreen> createState() => _ParcelScreenState();
}

class _ParcelScreenState extends State<ParcelScreen> {
  @override
  void initState() {
    super.initState();

    Get.find<ParcelController>().getParcelCategoryList(notify: true);
    Get.find<RideController>().initData();
    Get.find<LocationController>().initAddLocationData();
    Get.find<LocationController>().initParcelData();
    Get.find<ParcelController>().initParcelData();
    Get.find<MapController>().initializeData();
    Get.find<CategoryController>().setCouponFilterIndex(1, isUpdate: false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Stack(children: [
          BodyWidget(
            appBar: AppBarWidget(title: 'parcel_delivery'.tr),
            body: const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault), child: Column(children:  [

              BannerView(),

              DottedBorderCard(),

              ParcelCategoryView(),

            ])),
          ),

          Positioned(
            bottom: Dimensions.paddingSizeDefault,
            left:  Dimensions.paddingSizeDefault,
            right:  Dimensions.paddingSizeDefault,
            child: ButtonWidget(
              buttonText: 'add_parcel'.tr,
              onPressed: () {
                if(Get.find<ConfigController>().config!.maintenanceMode != null &&
                    Get.find<ConfigController>().config!.maintenanceMode!.maintenanceStatus == 1 &&
                    Get.find<ConfigController>().config!.maintenanceMode!.selectedMaintenanceSystem!.userApp == 1
                ){
                  showCustomSnackBar('maintenance_mode_on_for_parcel'.tr,isError: true);
                }else{
                  if(Get.find<ParcelController>().parcelCategoryList == null || Get.find<ParcelController>().parcelCategoryList!.isEmpty) {
                    showCustomSnackBar('no_parcel_category_found'.tr);
                  }else {
                    Get.find<ParcelController>().updateTabControllerIndex(0);
                    Get.find<ParcelController>().updateParcelState(ParcelDeliveryState.initial);
                    Get.to(() => const MapScreen(fromScreen: MapScreenType.parcel));
                  }
                }

              },
            ),
          ),

        ]),
      ),
    );
  }
}




