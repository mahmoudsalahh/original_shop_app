import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salahh/shared/shared.network/chase_helper.dart';
import 'package:salahh/shared/app_cubit/states.dart';

class AppCubit extends Cubit<AppState>{
  AppCubit() : super(AppIntialState());
  static AppCubit get(context) => BlocProvider.of(context);


  bool isDark = false;
  void changeAppTheme(
      {bool? fromCache}
      ){
    if(fromCache != Null){
      isDark == fromCache;
      emit(ChangeThemeState());
    }
    else{
    isDark = !isDark;
    print('mahmoud salahh');
    CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value){
    emit(ChangeThemeState());
    });}

  }

}