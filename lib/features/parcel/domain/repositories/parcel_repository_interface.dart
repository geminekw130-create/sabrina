import 'package:passageiro/interface/repository_interface.dart';

abstract class ParcelRepositoryInterface implements RepositoryInterface{
  Future<dynamic> getParcelCategory();
  Future<dynamic> getSuggestedVehicleCategory(String weight);
  Future<dynamic> getRunningParcelList(int offset);
  Future<dynamic> getUnpaidParcelList(int offset);
}