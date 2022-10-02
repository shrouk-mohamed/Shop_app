import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/modules/shop_app/register/cubit/cubit.dart';
import 'package:untitled1/modules/shop_app/register/cubit/states.dart';

import '../../../layout/shop_app/shop_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cache_helper.dart';


class ShopRegisterScreen extends StatelessWidget {
 ShopRegisterScreen({Key? key}) : super(key: key);

 var formKey = GlobalKey<FormState>();
 var nameController = TextEditingController();
 var emailController = TextEditingController();
 var phoneController = TextEditingController();
 var passwordController = TextEditingController();

 @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterState>(
        listener: (context,state){
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status) {
              print(state.loginModel.message);
              print(state.loginModel.data!.token);
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value) {
                token = state.loginModel.data!.token;
                NavigateAndFinish(context, ShopLayout());
              });
            } else {
              print(state.loginModel.message);
              showToast(
                text: state.loginModel.message!,
                state: ToastStates.ERROR,
              );
            }
          }
          },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(color: Colors.black),
                        ),
                        Text(
                          'Register now browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter your name';
                            }
                            return null;
                          },
                          label: 'User Name',
                          prefix: Icons.person,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter your email address';
                            }
                            return null;
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: ShopRegisterCubit.get(context).suffix,

                          onSubmit: (value){


                          },
                          isPassword: ShopRegisterCubit.get(context).isPassword,
                          suffixPressed: () {
                            ShopRegisterCubit.get(context).changePasswordVisibility();
                            //setState((){});
                          },
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'password is too short';
                            }
                            return null;
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter your phone';
                            }
                            return null;
                          },
                          label: 'Phone',
                          prefix: Icons.phone,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState ,//
                          builder: (context)=> defaultButton(
                            function: () {
                              if (formKey.currentState?.validate()??false) {
                                ShopRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'Register',
                            isUpperCase: true,
                          ),
                          fallback:  (context)=>const Center(child: CircularProgressIndicator()),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
