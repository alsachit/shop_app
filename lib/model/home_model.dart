class HomeModel {
  late bool status;
  String? message;
  late HomeModelData data;

  HomeModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? HomeModelData.fromJson(json['data']) : null)!;
  }

}

class HomeModelData {
  List<BannerModel> banners = [];
  List<ProductModel> products = [];

  HomeModelData.fromJson(Map<String, dynamic> json){
    json['banners'].forEach((element){
      banners.add(BannerModel.fromJson(element));
    });
    json['products'].forEach((element){
      products.add(ProductModel.formJson(element));
    });
  }
}

class BannerModel {
  int? id;
  String? image;
  BannerModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {

  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  dynamic inFavorites;
  dynamic inCart;

  ProductModel.formJson(Map<String, dynamic> json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}