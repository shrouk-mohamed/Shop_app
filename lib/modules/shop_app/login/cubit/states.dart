import 'package:untitled1/models/shop_app/login_model.dart';

abstract class ShopLoginState {}

class ShopLoginInitialState extends ShopLoginState{}

class ShopLoginLoadingState extends ShopLoginState{}

class ShopLoginSuccessState extends ShopLoginState
{
  final ShopLoginModel loginModel;
  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorState extends ShopLoginState{
  late final String error;
}

class ShopChangePasswordVisibilityState extends ShopLoginState{}
