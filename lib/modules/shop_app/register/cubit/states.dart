import 'package:untitled1/models/shop_app/login_model.dart';

abstract class ShopRegisterState {}

class ShopRegisterInitialState extends ShopRegisterState{}

class ShopRegisterLoadingState extends ShopRegisterState{}

class ShopRegisterSuccessState extends ShopRegisterState
{
  final ShopLoginModel loginModel;
  ShopRegisterSuccessState(this.loginModel);
}

class ShopRegisterErrorState extends ShopRegisterState{

}

class ShopRegisterChangePasswordVisibilityState extends ShopRegisterState{}
