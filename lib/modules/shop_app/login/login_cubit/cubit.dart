import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salahh/models/login_model.dart';
import 'package:salahh/modules/shop_app/login/login_cubit/states.dart';
import 'package:salahh/shared/shared.component/constant.dart';
import 'package:salahh/shared/shared.network/dio_helper.dart';
import 'package:salahh/shared/shared.network/end_points.dart';

class LoginCubit extends Cubit<ShopLoginStates>{

   LoginCubit() : super(ShopLoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel ;
  UserData? user;

  void loginUser({
    required String email ,
    required String password,


  }){
    emit(ShopLoginLoudingState());
    DioHelper.postData(
        url: LOGIN,
        data: {
         'email':email,
         'password':password,
        },
        token: token,
        ).then((value){
         // print(value.data);
          loginModel = ShopLoginModel.fromJson(value.data);
          print(loginModel!.message);
          emit(ShopLoginSucceesState(loginModel));
    }).catchError((error){
      emit(ShopLoginErrorState(error.toString()));
    });

  }

}
