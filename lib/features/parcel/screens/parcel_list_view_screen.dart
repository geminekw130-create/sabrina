import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passageiro/common_widgets/no_data_widget.dart';
import 'package:passageiro/features/parcel/controllers/parcel_controller.dart';
import 'package:passageiro/features/parcel/widgets/parcel_item.dart';
import 'package:passageiro/common_widgets/app_bar_widget.dart';
import 'package:passageiro/common_widgets/body_widget.dart';

class ParcelListViewScreen extends StatefulWidget {
  final String title;
  const ParcelListViewScreen({super.key, required this.title});

  @override
  State<ParcelListViewScreen> createState() => _ParcelListViewScreenState();
}

class _ParcelListViewScreenState extends State<ParcelListViewScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: BodyWidget(
          appBar: AppBarWidget(title: widget.title.tr),
          body: GetBuilder<ParcelController>(builder: (parcelController){
            return parcelController.parcelListModel == null || parcelController.parcelListModel!.data!.isEmpty ?
            const NoDataWidget(title: 'no_trip_found') :
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: parcelController.parcelListModel!.data!.length,
                itemBuilder: (context, index){
                  return ParcelItem(rideRequest: parcelController.parcelListModel!.data![index],index: index);
                }
            );
          }),
        ),
      ),
    );
  }
}
