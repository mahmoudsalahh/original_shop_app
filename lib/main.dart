import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:salahh/models/home_model.dart';
import 'package:salahh/modules/shop_app/home_screen/home_cubit/home_cubit.dart';
import 'package:salahh/modules/shop_app/home_screen/home_screen.dart';
import 'package:salahh/modules/shop_app/login/login_screen.dart';
import 'package:salahh/shared/app_cubit/cubit.dart';
import 'package:salahh/shared/shared.network/chase_helper.dart';
import 'package:salahh/shared/shared.network/dio_helper.dart';
import 'package:salahh/shared/app_cubit/states.dart';
import 'package:salahh/styles/themes.dart';
import 'layout/news_app/cubit/cubit.dart';
import 'layout/news_app/cubit/states.dart';
import 'layout/news_app/homeLayout.dart';
import 'modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:flutter/services.dart';

void main() async
{
  //SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  // SystemChrome.setEnabledSystemUIOverlays([]);
  // SystemChrome.setEnabledSystemUIOverlays(
  //     [SystemUiOverlay.top]);
  //بيتأكد اني كل حاجة في ال main خلصت وبعدين يفتح الأبليكشن
 WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
 var onBoarding =  CacheHelper.getData(key: 'onBoarding');
 var token = CacheHelper.getData(key: 'token');
print(token);

    Widget isWidget;
      if(onBoarding != null){
       if(token != null){
        isWidget= HomeScreen();}
       else {
         isWidget= LoginScreen();
       }
       }else{
        isWidget= OnBoardingScreen();
      }

 runApp( MyApp(
  isDark: isDark,
   isWidget:isWidget,

  ));
}
class MyApp extends StatelessWidget {
  var isDark ;
  final Widget? isWidget;

  MyApp({ this.isDark ,this.isWidget});

  @override
  Widget build(BuildContext context ) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => NewsCubit()..getBusines()..getSport()..getScience(),),
        BlocProvider(create: (BuildContext context) => AppCubit()
          ..changeAppTheme(fromCache:isDark),),
        BlocProvider(create: (BuildContext context) => HomeCubit()
          ..getHomeData()..getCategoriesData()..getFavoritesData()..getUserData()),
      ],
      child:BlocConsumer< AppCubit , AppState >(
        listener: (context , state){},
        builder: (context , state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme:darkTheme,
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: isWidget,
          );
        },
    ));

  }

}





