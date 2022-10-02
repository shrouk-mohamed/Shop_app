class CategoriesModel {
  final bool status;
  final CategoriesDataModel data;
  CategoriesModel({required this.status, required this.data});

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    final status = json['status'] as bool;
    final data =
        CategoriesDataModel.fromJson(json['data']) as CategoriesDataModel;

    return CategoriesModel(status: status, data: data);
  }
}

class CategoriesDataModel {
  int? current_page;
  final List<DataModel>? data = [];

  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    current_page = json['current_page'];
    json['data'].forEach((element) {
      data?.add(DataModel.fromJson(element));
    });
  }
}

class DataModel {
  final int id;
  final String name;
  final String image;
  DataModel({required this.id, required this.image, required this.name});
  factory DataModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as int;
    final name = json['name'] as String;
    final image = json['image'] as String;

    return DataModel(
      id: id,
      name: name,
      image: image,
    );
  }
}
