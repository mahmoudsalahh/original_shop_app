import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salahh/models/login_model.dart';
import 'package:salahh/modules/shop_app/login/login_cubit/states.dart';
import 'package:salahh/modules/shop_app/register/register_cubit/states.dart';
import 'package:salahh/shared/shared.network/dio_helper.dart';
import 'package:salahh/shared/shared.network/end_points.dart';

class RegisterCubit extends Cubit<ShopRegisterStates>{

  RegisterCubit() : super(ShopRegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

ShopLoginModel? loginModel;
  void registerUser({
    required String email ,
    required String password,
    required String name,
    required String phone,
  }){
    emit(ShopRegisterLoudingState());
    DioHelper.postData(
        url: REGISTER,
        data: {
          'name' : name,
          'email':email,
          'password':password,
          'phone':phone,
        }).then((value){
      // print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      //print(loginModel!.message);
      emit(ShopRegisterSucceesState(loginModel!));
    }).catchError((error){
      emit(ShopRegisterErrorState(error.toString()));
    });

  }


}