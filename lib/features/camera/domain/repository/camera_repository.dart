import 'package:image_picker/image_picker.dart';
import 'package:project/features/camera/domain/entities/product_photo_entity.dart';

abstract class CameraRepository {
  Future<int> getProduct(String barcodeId);
  Future<ProductPhotoEntity> getProductByPhoto(List<XFile> photo);
}
