class ChangeFavoritesModel{
  bool? status;
  String? Message;
  ChangeFavoritesModel.fromJson(Map<String , dynamic> json){
    status = json['status'];
    Message = json['Message'];
  }

}