import 'package:get/get.dart';

class RechargeBillController extends GetxController {
  final String billType;
  RechargeBillController({required this.billType});

  final RxList<Map<String, String>> operators = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchOperators();
  }

  void fetchOperators() {
    // Mock data; replace with API or service call
    switch (billType) {
      case 'mobile':
        operators.value = [
          {'name': 'Airtel', 'image': 'assets/mobile_logo/airtel_logo.png'},
          {
            'name': 'VideoconIdea Prepaid',
            'image': 'assets/mobile_logo/videocon-logo.png'
          },
          {
            'name': 'Jio Prepaid',
            'image': 'assets/mobile_logo/reliance_jio_logo.png'
          },
          {'name': 'BSNL Prepaid', 'image': 'assets/mobile_logo/BSNL-logo.png'},
          {
            'name': 'MTNL Delhi Prepaid',
            'image': 'assets/mobile_logo/MTNL-logo.png'
          },
          {
            'name': 'MTNL Mumbai Prepaid',
            'image': 'assets/mobile_logo/MTNL-logo.png'
          },
        ];
        break;
      case 'electricity':
        operators.value = [
          {
            'name': 'BSES - Rajdhani',
            'image': 'assets/electricity_logo/bses_delhi_icon.png'
          },
          {
            'name': 'BSES - Yamuna',
            'image': 'assets/electricity_logo/bses_delhi_icon.png'
          },
          {
            'name': 'Adani Electricity',
            'image': 'assets/electricity_logo/adani_electricity_icon.png'
          },
          {
            'name': 'Tata Powe - DDL',
            'image': 'assets/electricity_logo/tata_power_icon.png'
          },
          {
            'name': 'New Delhi electricity (NDMC)',
            'image':
                'assets/electricity_logo/new_delhi_municipal_council_official_logo.png'
          },
        ];
        break;
      case 'loan':
        operators.value = [
          {'name': 'Bajaj Finserv', 'image': 'assets/images/bajaj.png'},
        ];
        break;
      default:
        operators.value = [];
    }
  }

  String getTitle() {
    switch (billType) {
      case 'mobile':
        return 'Mobile Recharge';
      case 'electricity':
        return 'Electricity Bill';
      case 'loan':
        return 'Loan PayOff';
      case 'subscription':
        return 'Subscription Fee';
      default:
        return 'Recharge/Bill';
    }
  }

  String getTypeName() {
    return billType[0].toUpperCase() + billType.substring(1);
  }
}
