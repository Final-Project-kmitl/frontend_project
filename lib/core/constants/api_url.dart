import 'dart:io';

class AppUrl {
  static final String baseUrl = _getBaseUrl();

  static String _getBaseUrl() {
    if (Platform.isAndroid) {
      return "http://10.0.2.2:3000";
    } else if (Platform.isIOS) {
      return "http://ce67-38.cloud.ce.kmitl.ac.th/api";
    }
    return "http://ce67-38.cloud.ce.kmitl.ac.th/api";
  }

  static final splashPage = "$baseUrl/user/";

  static const signUp = "api/v1/auth/signup";

  //register
  static final user = "${baseUrl}/user";

  static final register = "${baseUrl}/auth/register";

  static final ingredient_search = "$baseUrl/ingredient/search";

  //get Favorite product
  static final getFavoriteProduct = "$baseUrl/user/favorite-products";

  //search

  static final search_photo = "${baseUrl}/ocr/extract-ingredients";

  static final product_search = "${baseUrl}/product/search";

  static final product_countFilter = "${baseUrl}/product/countFilter";

  //user
  static final profile_user = "${baseUrl}/user/profile";

  static final profile_ingredient = "${baseUrl}/user/allergic-ingredients";

  static final profile_skin_problem = "${baseUrl}/user/skin-problems";

  static final profile_skin_type = "${baseUrl}/user/skin-type";

  //product
  static final product_detail = "${baseUrl}/product";

  static final product_barcode = "${baseUrl}/product/barcode";

  static final product_relate = "${baseUrl}/product/related";

  //delete Favorite Product
  static final favorite_delete_add = "${baseUrl}/user/favorite-product";

  // check product routine in user add
  static final routine_check_product = "${baseUrl}/routine";

  // check no match in routine
  static final routine_check_no_match = "${baseUrl}/routine/conflict";

  // auto complete
  static final search_autocomplete = "${baseUrl}/product/autocomplete";

  //home page
  static final home_recommend = "${baseUrl}/product/get-recommend";
  static final home_recent = "${baseUrl}/product/get-recent";
  static final home_popular = "${baseUrl}/product/get-popular";
  static final home_favorite = "${baseUrl}/user/favorite-product";
}
