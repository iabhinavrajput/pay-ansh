class KycStatusModel {
  final bool aadhaar;
  final bool pan;
  final bool isFullyVerified;

  KycStatusModel({
    required this.aadhaar,
    required this.pan,
    required this.isFullyVerified,
  });

  factory KycStatusModel.fromJson(Map<String, dynamic> json) {
    return KycStatusModel(
      aadhaar: json['aadhaar'],
      pan: json['pan'],
      isFullyVerified: json['isFullyVerified'],
    );
  }
}
