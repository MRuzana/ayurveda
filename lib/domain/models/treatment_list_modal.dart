class TreatmentListModel {
  final String name;

  TreatmentListModel({
    required this.name,
  });

  factory TreatmentListModel.fromJson(Map<String, dynamic> json) {
    return TreatmentListModel(
      name: json['name'] ?? '',
    );
  }
}
