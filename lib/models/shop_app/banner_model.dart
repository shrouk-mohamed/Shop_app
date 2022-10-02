class BannerModel {
  final int id;
  final String image;
  BannerModel({required this.id, required this.image});

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    final int id = json['id'] as int;
    final String image = json['image'] as String;

    return BannerModel(
      id: id,
      image: image,
    );
  }
}
