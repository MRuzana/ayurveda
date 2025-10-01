class BranchListModel {
  final String name;

  BranchListModel({
    required this.name,
  });

  factory BranchListModel.fromJson(Map<String, dynamic> json) {
    return BranchListModel(
      name: json['name'] ?? '',
    );
  }
}
