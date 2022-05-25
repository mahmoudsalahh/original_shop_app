import 'package:dio/dio.dart';

abstract class NewsStates {}
class InitialState extends NewsStates{}
class ChangeBottomNavBAr extends NewsStates{}
//////////////////////
class NewGetBusinessSuccess extends NewsStates{}
class NewGetBusinessError extends NewsStates{
 final String  error;
 NewGetBusinessError(this.error);
}
class NewGetBusinessIoading extends NewsStates{}
//////////////////////////
class NewGetSportSuccess extends NewsStates{}
class NewGetSportError extends NewsStates{
 final String  error;
 NewGetSportError(this.error);
}
class NewGetSportIoading extends NewsStates{}
////////////////////////////////////////
class NewGetScienceSuccess extends NewsStates{}
class NewGetScienceError extends NewsStates{
 final String  error;
 NewGetScienceError(this.error);
}
class NewGetScienceIoading extends NewsStates{}
///////////////////////
class NewGetSearchSuccess extends NewsStates{}
class NewGetSearchError extends NewsStates{
 final String  error;
 NewGetSearchError(this.error);
}
class NewGetSearchIoading extends NewsStates{}
//////////////////////
class ChangeThemeState extends NewsStates{}