import 'package:project/features/routine/data/models/product_model.dart';

final List<Map<String, dynamic>> mockRoutineProduct = [
  {
    "id": "1",
    "brand": "Senka",
    "product": "Senka Perfect Whip",
    "img":
        "https://medias.watsons.co.th/publishing/WTCTH-297138-front-zoom.jpg?version=1733800323"
  },
  {
    "id": "2",
    "brand": "Senka",
    "product": "Senka Perfect Whip",
    "img":
        "https://medias.watsons.co.th/publishing/WTCTH-255543-front-KIPZvQs5-zoom.png?version=1735151487"
  },
  {
    "id": "3",
    "brand": "Senka",
    "product": "Senka Perfect Whip",
    "img":
        "https://medias.watsons.co.th/publishing/WTCTH-255543-front-KIPZvQs5-zoom.png?version=1735151487"
  },
];

// final List<Map<String, dynamic>> mockRoutineProduct = [
//   {
//     "id": "1",
//     "brand": "Senka",
//     "product": "Senka Perfect Whip",
//     "img":
//         "https://medias.watsons.co.th/publishing/WTCTH-297138-front-zoom.jpg?version=1733800323"
//   },
//   {
//     "id": "2",
//     "brand": "Senka",
//     "product": "Senka Perfect Whip",
//     "img":
//         "https://medias.watsons.co.th/publishing/WTCTH-255543-front-KIPZvQs5-zoom.png?version=1735151487"
//   },
//   {
//     "id": "3",
//     "brand": "Senka",
//     "product": "Senka Perfect Whip",
//     "img":
//         "https://medias.watsons.co.th/publishing/WTCTH-255543-front-KIPZvQs5-zoom.png?version=1735151487"
//   },
// ];

final List<ProductModel> mockProductData =
    mockRoutineProduct.map((e) => ProductModel.fromJson(e)).toList();
