import 'package:untitled1/models/shop_app/change_favorites_model.dart';
import 'package:untitled1/models/shop_app/login_model.dart';
import 'package:untitled1/models/shop_app/user_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}

class ShopSuccessChangeFavoritesState extends ShopStates {
  final ChangeFavoritesModel? changeFavoritsModel;

  ShopSuccessChangeFavoritesState(this.changeFavoritsModel);
}

class ShopChangeFavoritesState extends ShopStates {}

class ShopErrorChangeFavoritesState extends ShopStates {
  final String erorr;

  ShopErrorChangeFavoritesState(this.erorr);
}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {
  final String erorr;

  ShopErrorGetFavoritesState(this.erorr);
}

class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopSuccessUserDataState extends ShopStates {}

class ShopErrorUserDataState extends ShopStates {}

class ShopLoadingUserDataState extends ShopStates {}

class ShopSuccessUpdateUserState extends ShopStates {
  final UserModel userModel;

  ShopSuccessUpdateUserState(this.userModel);
}

class ShopErrorUpdateUserState extends ShopStates {}

class ShopLoadingUpdateUserState extends ShopStates {}
