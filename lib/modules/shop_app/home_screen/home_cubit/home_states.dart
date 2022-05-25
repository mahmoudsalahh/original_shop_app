import 'package:salahh/models/change_favorites_model.dart';
import 'package:salahh/models/login_model.dart';

abstract class HomeStates {}
class HomeScreenInitialState extends HomeStates{}
class changeItemState extends HomeStates{}
class LoudingHomeDataState extends HomeStates{}
class SuccessHomeDataState extends HomeStates{}
class ErrorHomeDataState extends HomeStates{}
/////////////
class LoudingCategoriesDataState extends HomeStates{}
class SuccessCategoriesDataState extends HomeStates{}
class ErrorCategoriesDataState extends HomeStates{}
///////////
class SuccesschangeFavoritesState extends HomeStates{
   ChangeFavoritesModel? model;
  SuccesschangeFavoritesState(this.model);

}
class ErrorchangeFavoritesState extends HomeStates{}
class changeFavoritesState extends HomeStates{}

class SuccesschangeFavoritesItemState extends HomeStates{}
//////// Favorites
class SuccessFavoritesDataState extends HomeStates{}
class ErrorFavoritesDataState extends HomeStates{}
class LoudingFavoritesDataState extends HomeStates{}
/////////////////////////////////
class SuccessUserDataState extends HomeStates{
   ShopLoginModel? userModel;
  SuccessUserDataState(this.userModel);
}
class ErrorUserDataState extends HomeStates{}



