import 'package:image_picker/image_picker.dart';
import 'package:project/features/camera/data/datasource/camera_datasource.dart';
import 'package:project/features/camera/domain/entities/product_photo_entity.dart';
import 'package:project/features/camera/domain/repository/camera_repository.dart';

class CameraRepositoryImpl implements CameraRepository {
  final CameraDatasource cameraDatasource;

  CameraRepositoryImpl({required this.cameraDatasource});
  @override
  Future<int> getProduct(String barcodeId) {
    return cameraDatasource.fetchProductByBarcode(barcodeId);
  }

  @override
  Future<ProductPhotoEntity> getProductByPhoto(List<XFile> photo) {
    return cameraDatasource.getchProductByPhoto(photo);
  }
}
