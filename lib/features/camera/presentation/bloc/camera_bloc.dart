import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:meta/meta.dart';
import 'package:project/features/camera/domain/entities/product_photo_entity.dart';
import 'package:project/features/camera/domain/usecases/getProduct.dart';
import 'package:project/features/camera/domain/usecases/getProductByPhoto.dart';

part 'camera_event.dart';
part 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraPhotoState> {
  final Getproduct getproduct;
  final Getproductbyphoto getproductbyphoto;
  CameraBloc({
    required this.getproduct,
    required this.getproductbyphoto,
  }) : super(BarcodeLoading()) {
    on<SearchBarcodeEvent>(_onSearchBarcodeEvent);
    on<SearchByPhoto>(_onSearchByPhoto);
  }

  Future<void> _onSearchByPhoto(
      SearchByPhoto event, Emitter<CameraPhotoState> emit) async {
    emit(PhotoLoading());
    try {
      print("RES");
      final res = await getproductbyphoto(event.imgs);
      print("RES RES L : $res");
      emit(PhotoLoaded(res: res));
    } catch (e) {
      print("E");

      emit(PhotoError(res: e.toString()));
    }
  }

  Future<void> _onSearchBarcodeEvent(
      SearchBarcodeEvent event, Emitter<CameraPhotoState> emit) async {
    emit(BarcodeLoading());

    try {
      final productId = await getproduct(event.barcode);
      await Future.delayed(Duration(seconds: 3));
      emit(BarcodeLoaded(productId: productId));
    } catch (e) {
      print("ERR : $e");
      emit(BarcodeError(message: "ไม่พบสินค้า"));
    }
  }
}
