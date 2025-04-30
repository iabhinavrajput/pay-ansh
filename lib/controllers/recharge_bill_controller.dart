import 'package:get/get.dart';

class RechargeBillController extends GetxController {
  final String billType;
  RechargeBillController({required this.billType});

  final RxList<Map<String, String>> operators = <Map<String, String>>[].obs;

  final RxString searchQuery = ''.obs;

  List<Map<String, String>> get filteredOperators {
    if (searchQuery.value.isEmpty) {
      return operators;
    } else {
      return operators
          .where((operator) => operator['name']!
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()))
          .toList();
    }
  }

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
            'image': 'assets/electricity_logo/BSES-Electricity-logo.png'
          },
          {
            'name': 'BSES - Yamuna',
            'image': 'assets/electricity_logo/BSES-Electricity-logo.png'
          },
          {
            'name': 'Adani Electricity',
            'image': 'assets/electricity_logo/AdaniElectricity-logo.png'
          },
          {
            'name': 'Tata Powe - DDL',
            'image': 'assets/electricity_logo/Tata-Power-logo.png'
          },
          {
            'name': 'New Delhi electricity (NDMC)',
            'image': 'assets/electricity_logo/NDMC-logo.png'
          },
        ];
        break;
      case 'loan':
        operators.value = [
          {
            'name': 'Tata Capital Limited',
            'image': 'assets/loan_icon/Tata-Capital-logo.png'
          },
          {
            'name': '121 Finance Private Limited',
            'image': 'assets/loan_icon/121-Finance-logo.png'
          },
          {
            'name': 'Aadhar Housing Finance Limited',
            'image': 'assets/loan_icon/Aadhar-hosuing-Finance-logo.png'
          },
          {
            'name': 'AU Small Finance Bank',
            'image': 'assets/loan_icon/AU-logo.png'
          },
          {
            'name': 'Aavas Finance Limited',
            'image': 'assets/loan_icon/Aavas-Finance-logo.png'
          },
          {
            'name': 'Aditya Birla Finance Limited',
            'image': 'assets/loan_icon/Aaditiya-Birla-Capital-logo.png'
          },
        ];
        break;
      case 'subscription':
        operators.value = [
          {
            'name': 'Disney Hotstar',
            'image': 'assets/subscription_logo/Disney-Hotstar-logo.png'
          },
          {
            'name': 'Jio Cinema',
            'image': 'assets/subscription_logo/Jio-Cinema-logo.png'
          },
          {
            'name': 'Netflix',
            'image': 'assets/subscription_logo/Netflix-logo.png'
          },
          {'name': 'Zee 5', 'image': 'assets/subscription_logo/Zee5-logo.png'},
          {
            'name': 'SonyLiv',
            'image': 'assets/subscription_logo/SonyLiv-logo.png'
          },
          {
            'name': 'MediBuddy',
            'image': 'assets/subscription_logo/Medibuddy-logo.png'
          },
          {
            'name': 'Apollo 24/7',
            'image': 'assets/subscription_logo/Apollo-logo.png'
          },
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
