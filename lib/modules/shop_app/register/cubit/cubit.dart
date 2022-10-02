import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/models/shop_app/login_model.dart';
import 'package:untitled1/modules/shop_app/login/cubit/states.dart';
import 'package:untitled1/modules/shop_app/register/cubit/states.dart';
import 'package:untitled1/shared/network/remote/dio_helper.dart';

import '../../../../shared/network/end_points.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterState>{
   ShopRegisterCubit() : super(ShopRegisterInitialState());
  static ShopRegisterCubit get(context)=> BlocProvider.of(context);
  late ShopLoginModel loginModel;
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,

  }){
    emit(ShopRegisterLoadingState());
   DioHelper.postData(
     url: REGISTER,
     data: {
       'name':name,
       'email':email,
       'password': password,
       'phone': phone,

     },).then((value){
     print(value.data);
    loginModel= ShopLoginModel.fromJson(value.data);
     print(loginModel.data?.token);
     print(loginModel.status);
     print(loginModel.message);

     emit(ShopRegisterSuccessState(loginModel));
   }).catchError((error){
     print(error.toString());
     emit(ShopRegisterErrorState());
   });
  }

  IconData suffix= Icons.visibility_outlined;
  bool isPassword=true;
  void changePasswordVisibility(){
    isPassword =!  isPassword;

    suffix=isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordVisibilityState());

  }
}
