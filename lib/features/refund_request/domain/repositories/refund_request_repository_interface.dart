import 'package:passageiro/data/api_client.dart';
import 'package:passageiro/interface/repository_interface.dart';

abstract class RefundRequestRepositoryInterface implements RepositoryInterface{
  Future<dynamic> getParcelRefundReasonList();
  Future<dynamic> sendRefundRequest({
    required String tripId,
    required String refundReason,
    String? refundNote,
    required double productApproximatePrice,
    required List<MultipartBody> proofImage,
  });
}