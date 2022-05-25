import 'package:salahh/models/login_model.dart';

abstract class ShopLoginStates{}
class ShopLoginInitialState extends ShopLoginStates{}
class ShopLoginLoudingState extends ShopLoginStates{}
class ShopLoginSucceesState extends ShopLoginStates{
 ShopLoginModel? loginModel ;
  ShopLoginSucceesState(this.loginModel);

}
class ShopLoginErrorState extends ShopLoginStates{
  final String error;
  ShopLoginErrorState(this.error);
}