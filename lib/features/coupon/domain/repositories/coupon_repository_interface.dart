import 'package:passageiro/interface/repository_interface.dart';

abstract class CouponRepositoryInterface implements RepositoryInterface{
  Future<dynamic> getCouponList(String categoryType, {int? offset = 1});
  Future<dynamic> customerAppliedCoupon(String couponId);
}