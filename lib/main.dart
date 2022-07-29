import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/cubit/cubit.dart';
import 'package:untitled/layout/cubit/states.dart';
import 'package:untitled/layout/shop_layout.dart';
import 'package:untitled/modules/on_boarding/on_boarding_screen.dart';
import 'package:untitled/modules/shop_login/shop_login.dart';
import 'package:untitled/shared/bloc_observer.dart';
import 'package:untitled/shared/components/constants.dart';
import 'package:untitled/shared/network/local/cache_helper.dart';
import 'package:untitled/shared/network/remote/dio_helper.dart';
import 'package:untitled/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  bool? onBoarding =  CacheHelper.getBool(key: 'onBoarding');
  token = CacheHelper.getString(key: 'token');
  debugPrint(token);
  Widget widget;
  if (onBoarding != null) {
    if (token != null) {
      widget = const HomeLayout();
    }else {
      widget = ShopLoginScreen();
    }
  }else {
    widget = const OnBoardingScreen();
  }
  print(onBoarding);
  DioHelper.init();
  BlocOverrides.runZoned(() {
    return runApp(MyApp(onBoarding: onBoarding, startWidget: widget,));
  },
  blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
   MyApp({Key? key, required this.onBoarding, required this.startWidget}) : super(key: key);

   final bool? onBoarding;
   final Widget startWidget;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ShopCubit()..getHomeData()..getCategoriesData()..getFavorites()..getUserData(),
        ),
      ],
      child: BlocConsumer <ShopCubit,ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Shop App',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}

