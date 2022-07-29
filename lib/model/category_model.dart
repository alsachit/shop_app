class CategoryModel {
  late bool status;
  String? message;
  late CategoryDataModel data;

  CategoryModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? CategoryDataModel.fromJson(json['data']) : null)! ;
  }
}

class CategoryDataModel {
  late int currentPage;
  late List<CategoryDetailModel> data = [];

  CategoryDataModel.fromJson(Map<String, dynamic> json){
    currentPage = json['current_page'];
    json['data'].forEach((element){
      data.add(CategoryDetailModel.fromJson(element));
    });
  }
}

class CategoryDetailModel {
  int? id;
  String? name;
  String? image;

  CategoryDetailModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}