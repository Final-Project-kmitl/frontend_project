part of 'camera_bloc.dart';

@immutable
sealed class CameraPhotoState {}

final class CameraInitial extends CameraPhotoState {}

class CameraBarcode extends CameraPhotoState {
  final int productId;
  CameraBarcode({required this.productId});
}

class BarcodeError extends CameraPhotoState {
  final String message;
  BarcodeError({required this.message});
}

class BarcodeLoaded extends CameraPhotoState {
  final int productId;
  BarcodeLoaded({required this.productId});
}

class PhotoLoading extends CameraPhotoState {}

class PhotoLoaded extends CameraPhotoState {
  final ProductPhotoEntity res;
  PhotoLoaded({required this.res});
}

class PhotoError extends CameraPhotoState {
  final String res;
  PhotoError({required this.res});
}

class BarcodeLoading extends CameraPhotoState {}
