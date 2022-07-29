import '../../modules/shop_login/shop_login.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

void signOut(context) {
  CacheHelper.clearData(key: 'token').then((value) {
    navigateAndFinish(context, ShopLoginScreen());
  });
}

 String? token = '';