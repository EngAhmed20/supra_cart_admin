class AdminModel {
  final String? id;
  final DateTime? createdAt;
  final String adminName;
  final String adminEmail;
  final String adminRole;

  AdminModel({
    this.id,
    this.createdAt,
    required this.adminName,
    required this.adminEmail,
    required this.adminRole,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      id: json['id'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      adminName: json['admin_name'] ?? '',
      adminEmail: json['admin_email'] ?? '',
      adminRole: json['admin_role'] ?? '',
    );
  }

  /// used for post requests only (don't include id or created_at)
  Map<String, dynamic> toJson() {
    return {
      'admin_name': adminName,
      'admin_email': adminEmail,
      'admin_role': adminRole,
    };
  }
}
