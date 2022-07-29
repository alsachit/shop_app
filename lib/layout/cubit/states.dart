import 'package:untitled/model/category_model.dart';

import '../../model/change_favorites_model.dart';
import '../../model/login_model.dart';

abstract class ShopStates {}

class ShopInitialStates extends ShopStates {}

class ShopChangeBottomNavBarState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {
  final String error;
  ShopErrorHomeDataState(this.error);
}

class ShopLoadingCategoryDataState extends ShopStates {}

class ShopSuccessCategoryDataState extends ShopStates {}

class ShopErrorCategoryDataState extends ShopStates {
  final String error;
  ShopErrorCategoryDataState(this.error);
}

class ShopLoadingChangeFavoritesDataState extends ShopStates {}

class ShopChangeFavoritesDataState extends ShopStates {}

class ShopSuccessChangeFavoritesDataState extends ShopStates {
  final ChangeFavoritesModel? favoritesModel;

  ShopSuccessChangeFavoritesDataState(this.favoritesModel);
}

class ShopErrorChangeFavoritesDataState extends ShopStates {
  final String error;
  ShopErrorChangeFavoritesDataState(this.error);
}

class ShopLoadingGetFavoritesDataState extends ShopStates {}

class ShopSuccessGetFavoritesDataState extends ShopStates {}

class ShopErrorGetFavoritesDataState extends ShopStates {
  final String error;

  ShopErrorGetFavoritesDataState(this.error);

}

class ShopLoadingGetUserDataState extends ShopStates {}

class ShopSuccessGetUserDataState extends ShopStates {
  final LoginModel? loginModel;

  ShopSuccessGetUserDataState(this.loginModel);
}

class ShopErrorGetUserDataState extends ShopStates {
  final String error;

  ShopErrorGetUserDataState(this.error);

}

class ShopLoadingUpdateUserDataState extends ShopStates {}

class ShopSuccessUpdateUserDataState extends ShopStates {
  final LoginModel? loginModel;

  ShopSuccessUpdateUserDataState(this.loginModel);
}

class ShopErrorUpdateUserDataState extends ShopStates {
  final String error;

  ShopErrorUpdateUserDataState(this.error);

}

class ShopLoadingGetCategoryProductsDataState extends ShopStates {}

class ShopSuccessGetCategoryProductsDataState extends ShopStates {}

class ShopErrorGetCategoryProductsDataState extends ShopStates {
  final String error;

  ShopErrorGetCategoryProductsDataState(this.error);

}