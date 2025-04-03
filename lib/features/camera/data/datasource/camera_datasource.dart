import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:project/core/constants/api_url.dart';
import 'package:project/core/network/dio_client.dart';
import 'package:project/features/camera/domain/entities/product_photo_entity.dart';
import 'package:project/service_locator.dart';

abstract class CameraDatasource {
  Future<int> fetchProductByBarcode(String barcode);
  Future<ProductPhotoEntity> getchProductByPhoto(List<XFile> images);
}

class apiServiceCamera implements CameraDatasource {
  final dio = sl<DioClient>();
  @override
  Future<int> fetchProductByBarcode(String barcode) async {
    final url = Uri.parse("${AppUrl.product_barcode}/$barcode");
    try {
      final res = await dio.get(url.toString());

      if (res.statusCode == 200) {
        final jsonData = res.data['product']['id'];
        print(jsonData.runtimeType);

        return jsonData;
      }
      throw Exception("Product not found");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<ProductPhotoEntity> getchProductByPhoto(List<XFile> images) async {
    print("GET");
    try {
      FormData formData = FormData.fromMap({
        'images': [
          for (var image in images)
            await MultipartFile.fromFile(
              image.path,
              filename: basename(image.path),
              contentType: MediaType('image', 'jpeg'),
            ),
        ]
      });

      final res = await dio.post(
        AppUrl.search_photo,
        data: formData,
        options: Options(
          headers: {'Content-Type': 'multipart/form-data'},
        ),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        final jsonData = ProductPhotoEntity.fromJson(res.data);
        return jsonData;
      } else {
        print("Fail");
        throw Exception("Failed to get product by photo: ${res.statusCode}");
      }
    } catch (e) {
      print("Error getting product by photo: $e");
      throw Exception("Error getting product by photo: $e");
    }
  }
}
