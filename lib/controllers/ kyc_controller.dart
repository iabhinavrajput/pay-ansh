import 'package:get/get.dart';
import '../models/kyc_status_model.dart';
import '../services/kyc_service.dart';

class KycController extends GetxController {
  Rx<KycStatusModel?> kycStatus = Rx<KycStatusModel?>(null);
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    fetchKyc();
    super.onInit();
  }

  void fetchKyc() async {
    isLoading.value = true;
    final result = await KycService.fetchKycStatus();
    if (result != null) {
      kycStatus.value = result;
    }
    isLoading.value = false;
  }
}
