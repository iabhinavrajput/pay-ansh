
import 'package:payansh/utils/environment.dart';

class DigioConfig {
  static const Map<DigioEnvironment, String> clientIds = {
    DigioEnvironment.sandbox: "AIVXMGKKJ2O1R668PJOYPV66RGDBBEVZ",
    DigioEnvironment.production: "AIVXMGKKJ2O1R668PJOYPV66RGDBBEVZ",
    DigioEnvironment.sandboxPanCard: "AIVXMGKKJ2O1R668PJOYPV66RGDBBEVZ",
    DigioEnvironment.productionPanCard: "AIVXMGKKJ2O1R668PJOYPV66RGDBBEVZ",
  };

  static const Map<DigioEnvironment, String> clientSecrets = {
    DigioEnvironment.sandbox: "AJIBVQ7MT4FBZ318UG9S5SNG9P56CZLV",
    DigioEnvironment.production: "AJIBVQ7MT4FBZ318UG9S5SNG9P56CZLV",
    DigioEnvironment.sandboxPanCard: "AJIBVQ7MT4FBZ318UG9S5SNG9P56CZLV",
    DigioEnvironment.productionPanCard: "AJIBVQ7MT4FBZ318UG9S5SNG9P56CZLV",
  };

  static DigioEnvironment currentEnvironment = DigioEnvironment.sandbox;

  static String get clientId => clientIds[currentEnvironment]!;
  static String get clientSecret => clientSecrets[currentEnvironment]!;

  static String get baseUrl {
    switch (currentEnvironment) {
      case DigioEnvironment.sandbox:
      case DigioEnvironment.sandboxPanCard:
        return "https://ext.digio.in:444/";
      case DigioEnvironment.production:
      case DigioEnvironment.productionPanCard:
        return "https://api.digio.in/";
      default:
        return "https://ext.digio.in:444/";
    }
  }

  // Endpoints
  static const String client = "client/kyc/v2/";
  static const String kycReq = "request/";

  static String get withTemplate => "$client$kycReq" + "with_template";
  static String get verifyResponse => "$client" + "id/response";

  static const String kycInitiateEndpoint = "/kyc/initiate";
  static const String kycStatusEndpoint = "/kyc/status";
}
