part of 'camera_bloc.dart';

@immutable
sealed class CameraEvent {}

class SearchBarcodeEvent extends CameraEvent {
  final String barcode;
  SearchBarcodeEvent({required this.barcode});
}

class SearchByPhoto extends CameraEvent {
  final List<XFile> imgs;
  SearchByPhoto({required this.imgs});
}
