import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salahh/layout/news_app/cubit/states.dart';
import 'package:salahh/modules/news_app/besiness/business.dart';
import 'package:salahh/modules/news_app/science/scince_screen.dart';
import 'package:salahh/modules/news_app/setting/setting_screen.dart';
import 'package:salahh/modules/news_app/sports/sport_screen.dart';

import 'package:salahh/shared/shared.network/chase_helper.dart';
import 'package:salahh/shared/shared.network/dio_helper.dart';
import 'package:salahh/main.dart';


class NewsCubit extends Cubit<NewsStates>{
  NewsCubit():super(InitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex =0;

  List<BottomNavigationBarItem> BottomNav = [
    BottomNavigationBarItem(
        icon: Icon(Icons.business),
            label : 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label : 'Sport',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label : 'Science',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label : 'Setting',
    ),
  ];
  List<Widget> screens = [
    Business(),
    Sport(),
    Science(),
    Setting()
  ];

  void changeItem(index){
    currentIndex = index;
    //if(index == 1 )
     // getSport();
    emit(ChangeBottomNavBAr());
  }

  List<dynamic> business = [];
  void getBusines(){
    emit (NewGetBusinessIoading());
    DioHelper.getData(
        //https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=c6264145da6d443b96e0d58c4ae0f81d
        url: 'v2/top-headlines',
        query: {
          'country':'us',
          'category':'business',
          'apikey':'c6264145da6d443b96e0d58c4ae0f81d',
        }).then((value)
    {
      //print(value.data.toString());
      business = value.data['articles'];
      print(business[0]);
      //print (business[0]['articles']);
      // print(business);
      // print(business.length);
      emit(NewGetBusinessSuccess());
    }
    ).catchError((error){
      print(error.toString());
      emit (NewGetBusinessError(error));
    });
  }

  List<dynamic> sport = [];
  void getSport(){
    emit (NewGetSportIoading());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'us',
          'category':'sport',
          'apikey':'c6264145da6d443b96e0d58c4ae0f81d',
        }).then((value)
    {
      //print(value.data.toString());
      sport = value.data['articles'];
      print(sport[0]);
      //print (business[0]['articles']);
      // print(business);
      // print(business.length);
      emit(NewGetSportSuccess());
    }
    ).catchError((error){
      print(error.toString());
      emit (NewGetSportError(error));
    });
  }

  List<dynamic> science = [];
  void getScience(){
    emit (NewGetScienceIoading());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'us',
          'category':'science',
          'apikey':'c6264145da6d443b96e0d58c4ae0f81d',
        }).then((value)
    {
      //print(value.data.toString());
      science = value.data['articles'];
      print(science[0]);
      //print (business[0]['articles']);
      // print(business);
      // print(business.length);
      emit(NewGetScienceSuccess());
    }
    ).catchError((error){
      print(error.toString());
      emit (NewGetScienceError(error));
    });
  }

  List<dynamic> search = [];
  void getSearch(String value){
    emit (NewGetSearchIoading());
    DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q':'$value',
          'apikey':'c6264145da6d443b96e0d58c4ae0f81d',
        }).then((value)
    {
      //print(value.data.toString());
      search = value.data['articles'];
      //print(search[0]);
      //print (business[0]['articles']);
      // print(business);
      // print(business.length);
      emit(NewGetSearchSuccess());
    }
    ).catchError((error){
      print(error.toString());
      emit (NewGetSearchError(error));
    });
  }

  bool isDark = false;
  void changeTheme(){
    // if(fromCache != Null){
    //   isDark == fromCache;
    //   emit(ChangeThemeState());
    // }
    //else{
    isDark = !isDark;
    print('mahmoud');
    //CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value){
      emit(ChangeThemeState());
    //});}

  }
}