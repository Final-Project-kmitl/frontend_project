import 'package:project/features/camera/domain/repository/camera_repository.dart';

class Getproduct {
  final CameraRepository cameraRepository;

  Getproduct({required this.cameraRepository});

  Future<int> call(String barcodeId) {
    return cameraRepository.getProduct(barcodeId);
  }
}
