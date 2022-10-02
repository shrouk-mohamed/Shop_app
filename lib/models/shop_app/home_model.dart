import 'package:untitled1/models/shop_app/products_model.dart';
import 'banner_model.dart';

class HomeModel {
  final bool status;
  final HomeDataModel data;
  HomeModel({required this.status, required this.data});
  factory HomeModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final bool status = json['status'] as bool;
    final HomeDataModel data =
        HomeDataModel.fromJson(json['data']) as HomeDataModel;

    return HomeModel(status: status, data: data);
  }
}

class HomeDataModel {
  final List<BannerModel> banners = [];
  final List<ProductModel> products = [];

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(BannerModel.fromJson(element));
    });
    json['products'].forEach((element) {
      products.add(ProductModel.fromJson(element));
    });
  }
}
