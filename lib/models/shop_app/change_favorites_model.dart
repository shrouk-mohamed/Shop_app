class ChangeFavoritesModel {
  final bool status;
  final String message;
  ChangeFavoritesModel({required this.status, required this.message});
  factory ChangeFavoritesModel.fromJson(Map<String, dynamic> json) {
    final status = json['status'] as bool;
    final message = json['message'] as String;
    return ChangeFavoritesModel(
      status: status,
      message: message,
    );
  }
}
