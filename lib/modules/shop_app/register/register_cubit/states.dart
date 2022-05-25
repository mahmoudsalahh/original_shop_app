import 'package:salahh/models/login_model.dart';

abstract class ShopRegisterStates{}
class ShopRegisterInitialState extends ShopRegisterStates{}
class ShopRegisterLoudingState extends ShopRegisterStates{}
class ShopRegisterSucceesState extends ShopRegisterStates{
 final ShopLoginModel? loginModel;
 ShopRegisterSucceesState(this.loginModel);
}
class ShopRegisterErrorState extends ShopRegisterStates{
  final String error;
  ShopRegisterErrorState(this.error);
}