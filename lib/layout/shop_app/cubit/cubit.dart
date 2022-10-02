import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/layout/shop_app/cubit/states.dart';
import 'package:untitled1/models/shop_app/categories_model.dart';
import 'package:untitled1/models/shop_app/home_model.dart';
import 'package:untitled1/modules/shop_app/products/products_screen.dart';
import 'package:untitled1/shared/components/constants.dart';
import 'package:untitled1/shared/network/remote/dio_helper.dart';
import '../../../models/shop_app/change_favorites_model.dart';
import '../../../models/shop_app/favorites_model.dart';
import '../../../models/shop_app/user_model.dart';
import '../../../modules/shop_app/categories/categories_screen.dart';
import '../../../modules/shop_app/favorites/favorites_screen.dart';
import '../../../modules/shop_app/settings/settings_screen.dart';
import '../../../shared/network/end_points.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool>? favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      //print(homeModel?.data.banners[0].image);
      //print(homeModel?.status);
      homeModel?.data.products.forEach((element) {
        favorites?.addAll({
          element.id: element.in_favorites,
        });
      });
      // print(favorites.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesData() async {
    await DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((erorr) {
      print(erorr);
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? favoritesModel;
  void changeFavoritesData(int productId) async {
    favorites?[productId] = !favorites![productId]!;
    emit(ShopChangeFavoritesState());
    await DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      favoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (!favoritesModel!.status!) {
        //law fe 8alat yrga3ha blue tane mn nafso w el 3aks
        favorites?[productId] = !favorites![productId]!;
      } else {
        getFavoritesData();
      }
      //print(value.data);
      emit(ShopSuccessChangeFavoritesState(favoritesModel));
    }).catchError((erorr) {
      favorites?[productId] = !favorites![productId]!;
      emit(ShopErrorChangeFavoritesState(erorr));
      print(erorr);
    });
  }

  FavoritesModel? favoritesModell;
  void getFavoritesData() async {
    emit(ShopLoadingGetFavoritesState());
    await DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModell = FavoritesModel.fromJson(value.data);
      // printFullText("==================***==================");
      printFullText(value.data.toString());
      emit(ShopSuccessGetFavoritesState());
    }).catchError((erorr) {
      emit(ShopErrorGetFavoritesState(erorr));
      print(erorr);
    });
  }

  UserModel? userModel;
  void getUserData() async {
    emit(ShopLoadingUserDataState());
    await DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = UserModel.fromJson(value.data);
      print("===============++++++++==================");
      printFullText(userModel!.data!.name!);
      printFullText(userModel!.data!.email!);
      emit(ShopSuccessUserDataState());
    }).catchError((erorr) {
      print(erorr);
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) async {
    emit(ShopLoadingUpdateUserState());
    await DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'phone': phone,
        'email': email,
      },
    ).then((value) {
      userModel = UserModel.fromJson(value.data);
      // print("===============++++++++==================");
      // printFullText(userModel!.data!.name!);
      //printFullText(userModel!.data!.email!);

      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((erorr) {
      print(erorr);
      emit(ShopErrorUpdateUserState());
    });
  }
}
