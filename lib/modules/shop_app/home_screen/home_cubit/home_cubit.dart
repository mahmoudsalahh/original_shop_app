import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salahh/models/categories_model.dart';
import 'package:salahh/models/change_favorites_model.dart';
import 'package:salahh/models/favorite_model.dart';
import 'package:salahh/models/home_model.dart';
import 'package:salahh/models/login_model.dart';
import 'package:salahh/modules/shop_app/home_screen/categories/category_screen.dart';
import 'package:salahh/modules/shop_app/home_screen/favorit/favorit_screen.dart';
import 'package:salahh/modules/shop_app/home_screen/home_cubit/home_states.dart';
import 'package:salahh/modules/shop_app/home_screen/products/products_screen.dart';
import 'package:salahh/modules/shop_app/home_screen/settings/settings_screen.dart';
import 'package:salahh/modules/shop_app/login/login_cubit/cubit.dart';
import 'package:salahh/shared/shared.component/constant.dart';
import 'package:salahh/shared/shared.network/dio_helper.dart';
import 'package:salahh/shared/shared.network/end_points.dart';

class HomeCubit extends Cubit<HomeStates>{
  HomeCubit() : super(HomeScreenInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomNavBarItem = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',

    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.category_outlined),
      label: 'Categories',

    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Favorites',

    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',

    ),
    ];
  List<Widget> bottomScreen = [
    ProductsScreen(),
    CategoryScreen(),
    FavoritScreen(),
    SettingsScreen()

  ];
  void changeItem(index){
    currentIndex = index ;
      emit(changeItemState());
  }
  HomeModel? homeModel;
  Map<int , bool>? favorites;
  void getHomeData(){
    emit(LoudingHomeDataState());
     DioHelper.getData(url: Home).then((value){
       favorites ={};
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data.products.forEach((element) {
        favorites!.addAll({
          element.id : element.inFavorites,
        });
      });

      emit(SuccessHomeDataState());
    });
    //     .catchError((error){
    //   print(error.toString());
    //   emit(ErrorHomeDataState());
    // });
  }
  CategoriesModel? categoriesModel;
  void getCategoriesData(){
    emit(LoudingCategoriesDataState());
    DioHelper.getData(url: GET_CATEGORIES).then((value){
      categoriesModel = CategoriesModel.fromJson(value.data);
      //print(categoriesModel!.status);
      emit(SuccessCategoriesDataState());
    }).catchError((error){
      print(error.toString());
      emit(ErrorCategoriesDataState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId){
    favorites![productId] = !favorites![productId]!;
    print(favorites);
    //emit(SuccesschangeFavoritesItemState());
    emit(changeFavoritesState());
    DioHelper.postData(
        url: FAVORITES,
        data:{
    'product_id' : productId
    },
      token: token,
    ).
    then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      //print(changeFavoritesModel!.status);
      if(!changeFavoritesModel!.status!){
        favorites![productId] = !favorites![productId]!;
      }else{
        getFavoritesData();
      }

      //print(value.data);
      emit(SuccesschangeFavoritesState(changeFavoritesModel!));
    });

    // .catchError((error){
    //   favorites[productId] = !favorites[productId]!;
    //   emit(ErrorchangeFavoritesState());
    // });
  }
  //////////////////////////////////
  FavoriteModel? favoriteModel;
  void getFavoritesData(){
    DioHelper.getData(url: FAVORITES , token: token).then((value){
      favoriteModel = FavoriteModel.fromJson(value.data);
      //print(value.data);
      // favoriteModel!.data.products.forEach((element) {
      //   favorites.addAll({
      //     element.id : element.inFavorites,
      //   });
      // });

      emit(SuccessFavoritesDataState());
    }).catchError((error){
      print(error.toString());
      emit(ErrorFavoritesDataState());
    });
  }
///////////////////////////////////////////
  ShopLoginModel? userModel;
  void getUserData(){
    DioHelper.getData(url: PROFILE , token: token).then((value){
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      emit(SuccessUserDataState(userModel!));
    }).catchError((error){
      print(error.toString());
      emit(ErrorUserDataState());
    });
  }

}