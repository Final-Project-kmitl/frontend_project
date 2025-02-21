import 'dart:io';


class AppUrl {
  static final String baseUrl = _getBaseUrl();

  static String _getBaseUrl() {
    if (Platform.isAndroid) {
      return "http://10.0.2.2:3000";
    } else if (Platform.isIOS) {
      return "http://localhost:3000";
    }
    return "http://localhost:3000";
  }

  static final splashPage = "$baseUrl/user/";

  static const signUp = "api/v1/auth/signup";

  //get Favorite product
  static String getFavoriteProduct(String userId) {
    return "$baseUrl/user/$userId/favorite-products";
  }

  //product
  static final product_detail = "${baseUrl}/product";

  //delete Favorite Product
  static final favorite_delete = "${baseUrl}/user/favorite-product";

  // check product routine in user add
  static final routine_check_product = "${baseUrl}/routine-product";

  // check no match in routine
  static final routine_check_no_match = "${baseUrl}/check-no-match";

  //delete routine Id
  static final routine_delete_product = "${baseUrl}/delete-product-routine";

  //home page
  static final home_recommend = "${baseUrl}/product/get-recommend";
  static final home_recent = "${baseUrl}/product/get-recent";
  static final home_popular = "${baseUrl}/product/get-popular";
  static final home_favorite = "${baseUrl}/user/favorite-product";
}
