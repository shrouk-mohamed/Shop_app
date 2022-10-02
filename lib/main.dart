import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:untitled1/shared/bloc_observer.dart';
import 'package:untitled1/shared/components/constants.dart';
import 'package:untitled1/shared/network/local/cache_helper.dart';
import 'package:untitled1/shared/network/remote/dio_helper.dart';
import 'package:untitled1/shared/styles/themes.dart';

import 'layout/shop_app/cubit/cubit.dart';
import 'layout/shop_app/cubit/states.dart';
import 'layout/shop_app/shop_layout.dart';
import 'modules/basics_app/login/login.dart';


void main() {
  WidgetsFlutterBinding();
  BlocOverrides.runZoned(
        () async {
      DioHelper.init();
      await CacheHelper.init();
      bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
      late Widget widget;
      token = CacheHelper.getData(key: 'token');
      print("=====================================================");
      print(token);
      if (onBoarding != null) {
        if (token != null)
          widget = ShopLayout();
        else {
          widget = LoginScreen();
        }
      } else {
        widget = OnBoardingScreen();
      }

      runApp(MyApp(
        //onBoarding: onBoarding,
        startWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  MyApp({/*required this.onBoarding,*/ required this.startWidget});
  //late final bool onBoarding;
  late final Widget startWidget;
  //late final bool onBoarding;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ShopCubit()
              ..getHomeData()
              ..getCategoriesData()
              ..getFavoritesData()
              ..getUserData()
              ,
          ),
        ],
        child: BlocConsumer<ShopCubit, ShopStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              theme: lightTheme,
              debugShowCheckedModeBanner: false,
              home: startWidget,
              // onBoarding ? LoginScreen() : OnBoarding(),
            );
          },
        ),
      ),
    );
  }
}
