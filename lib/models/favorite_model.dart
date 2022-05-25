import 'package:salahh/models/home_model.dart';

class FavoriteModel{
  bool? status ;
  late FavoriteDataModel data;
  FavoriteModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    data = FavoriteDataModel.fromJson(json['data']);
  }
}
class FavoriteDataModel{
  List<Data> favoritesItem=[];
  FavoriteDataModel.fromJson(Map<String,dynamic> json){

    json['data'].forEach((element){
      favoritesItem.add(Data.fromJson(element));
    });

  }
}

class Data{
  late int id ;
  late Product? product;
  Data.fromJson(Map<String,dynamic> json){
    id = json['id'];
    product =  Product.fromJson(json['product']);

  }
}
class Product{
  late int id ;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;


  Product.fromJson(Map<String,dynamic> json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];



  }
}