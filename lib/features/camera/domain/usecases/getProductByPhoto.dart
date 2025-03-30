import 'package:image_picker/image_picker.dart';
import 'package:project/features/camera/domain/entities/product_photo_entity.dart';
import 'package:project/features/camera/domain/repository/camera_repository.dart';

class Getproductbyphoto {
  final CameraRepository cameraRepository;
  Getproductbyphoto({required this.cameraRepository});

  Future<ProductPhotoEntity> call(List<XFile> photos) {
    return cameraRepository.getProductByPhoto(photos);
  }
}
