import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/cubit/states.dart';
import 'package:untitled/model/category_model.dart';
import 'package:untitled/model/category_products_model.dart';
import 'package:untitled/model/favorites_model.dart';
import 'package:untitled/model/home_model.dart';
import 'package:untitled/modules/categories/categories_screen.dart';
import 'package:untitled/modules/favorites/favorites_screen.dart';
import 'package:untitled/modules/products/products_screen.dart';
import 'package:untitled/modules/settings/settings_screen.dart';
import 'package:untitled/shared/network/end_points.dart';
import 'package:untitled/shared/network/remote/dio_helper.dart';

import '../../model/change_favorites_model.dart';
import '../../model/login_model.dart';
import '../../shared/components/constants.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialStates());


  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens =  [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen()
  ];

  Map<int?, bool> favorites = {};

  HomeModel? homeModel;
  CategoryModel? categoryModel;

  void changeBottomNavBarState(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavBarState());
  }

  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      for (var element in homeModel!.data.products) {
        favorites.addAll({
          element.id: element.inFavorites
        });
      }

      debugPrint(favorites.toString());

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ShopErrorHomeDataState(error.toString()));
    });
  }

  void getCategoriesData() {
    emit(ShopLoadingCategoryDataState());

    DioHelper.getData(url: GET_CATEGORIES).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      emit(ShopSuccessCategoryDataState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ShopErrorCategoryDataState(error.toString()));
    });
  }

  CategoryProductsModel? categoryProductsModel;

  void getCategoryProducts({required int? categoryId}){
    emit(ShopLoadingGetCategoryProductsDataState());

    DioHelper.getData(
        url: CATEGORY_PRODUCTS,
      token: token,
      query: {
          'category_id' : '$categoryId'
      }
    ).then((value){
      categoryProductsModel = CategoryProductsModel.fromJson(value.data);
      emit(ShopSuccessGetCategoryProductsDataState());
    }).catchError((error){
      emit(ShopErrorGetCategoryProductsDataState(error));
      debugPrint(error.toString());
    });
  }

  late ChangeFavoritesModel changeFavoritesModel;

  void changeFavorites(int? productId) {
    favorites[productId] = !(favorites[productId])!;
    emit(ShopChangeFavoritesDataState());
    DioHelper.postData(
        url: FAVORITES,
        data: {
          'product_id': productId
        },
        token: token
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      debugPrint(value.data.toString());
      if (!changeFavoritesModel.status) {
        favorites[productId] = !(favorites[productId])!;
      } else {
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesDataState(changeFavoritesModel));
    }).catchError((error) {
      favorites[productId] = !(favorites[productId])!;
      debugPrint(error.toString());
      emit(ShopErrorChangeFavoritesDataState(error.toString()));
    });
  }

  late FavoritesModel favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesDataState());
    DioHelper.getData(
        url: FAVORITES,
        token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesDataState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ShopErrorGetFavoritesDataState(error.toString()));
    });
  }

  LoginModel? loginModel;

  void getUserData() {
    emit(ShopLoadingGetUserDataState());
    DioHelper.getData(
        url: PROFILE,
        token: token
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      debugPrint(loginModel!.data!.name);
      emit(ShopSuccessGetUserDataState(loginModel));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ShopErrorGetUserDataState(error.toString()));
    });
  }

  void updateUserData({
  required String name,
  required String phone,
  required String email,
}) {
    emit(ShopLoadingUpdateUserDataState());
    DioHelper.putData(
        url: UPDATE_PROFILE,
        token: token,
        data: {
          'name' : name,
          'phone' : phone,
          'email' : email,
        }
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      debugPrint(loginModel!.data!.name);
      emit(ShopSuccessUpdateUserDataState(loginModel));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ShopErrorUpdateUserDataState(error.toString()));
    });
  }

}