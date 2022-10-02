import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/layout/shop_app/cubit/cubit.dart';
import 'package:untitled1/layout/shop_app/cubit/states.dart';
import 'package:untitled1/shared/components/components.dart';

import '../../../shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
   SettingsScreen({Key? key}) : super(key: key);
   var formKey = GlobalKey<FormState>();
   var nameController = TextEditingController();
   var emailController = TextEditingController();
   var phoneController = TextEditingController();

   @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var model = ShopCubit.get(context).userModel!;
        nameController.text=model.data!.name!;
        emailController.text=model.data!.email!;
        phoneController.text=model.data!.phone!;


        return  ConditionalBuilder(
          condition: ShopCubit.get(context).userModel  != null ,
          builder: (BuildContext context)=>Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if(state is ShopLoadingUpdateUserState)
                  const LinearProgressIndicator(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField
                    (
                    controller: nameController,
                    type: TextInputType.name,
                    validate: (value){
                      if(value==null ||  value.isEmpty){
                        return 'name must not be empty';
                      }
                      return null;
                    },
                    label: 'Name',
                    prefix: Icons.person,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField
                    (
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validate: (value){
                      if(value==null || value.isEmpty){
                        return 'email must not be empty';
                      }
                      return null;
                    },
                    label: 'Email Address',
                    prefix: Icons.email_outlined,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField
                    (
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (value){
                      if( value == null || value.isEmpty){
                        return 'phone must not be empty';
                      }
                      return null;
                    },
                    label: 'Phone',
                    prefix: Icons.phone,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(function: (){
                    signOut(context);
                  },
                    text: 'LOGOUT',
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    function: (){
                      if(formKey.currentState!.validate()){
                        ShopCubit.get(context).updateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text
                        );
                      }
                      },
                    text: 'UPDATE',
                  ),
                ],
              ),
            ),
          ),
          fallback: (BuildContext context)=> const Center(child: CircularProgressIndicator()),

        );

      },

    );
  }
}
