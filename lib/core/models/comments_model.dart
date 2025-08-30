class CommentModel {
  final String id;
  final DateTime createdAt;
  final String userName;
  final String forUser;
  final String forProduct;
  final String comments;
  final String? reply;

  CommentModel({
    required this.id,
    required this.createdAt,
    required this.userName,
    required this.forUser,
    required this.forProduct,
    required this.comments,
    this.reply,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      userName: json['user_name'],
      forUser: json['for_user'],
      forProduct: json['for_product'],
      comments: json['comments'],
      reply: json['reply'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_at': createdAt.toIso8601String(),
      'user_name': userName,
      'for_user': forUser,
      'for_product': forProduct,
      'comments': comments,
      'reply': reply,
    };
  }
}