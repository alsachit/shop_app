class CategoryProductsModel {
  bool? status;
  Data? data;


  CategoryProductsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? currentPage;
  List<CategoryProductData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  Null? nextPageUrl;
  String? path;
  int? perPage;
  Null? prevPageUrl;
  int? to;
  int? total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <CategoryProductData>[];
      json['data'].forEach((v) {
        data!.add(CategoryProductData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}

class CategoryProductData {
  int? id;
  double? price;
  double? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;
  List<String>? images;
  bool? inFavorites;
  bool? inCart;


  CategoryProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
