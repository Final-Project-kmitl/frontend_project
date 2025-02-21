import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:project/features/product/domain/entities/product_entity.dart';
import 'package:project/features/product/domain/usecases/get_product_detail.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductDetail getProductDetail;
  ProductBloc({
    required this.getProductDetail,
  }) : super(ProductInitial()) {
    on<ProductDetailRequestedEvent>(_onProductLoad);
  }

  Future<void> _onProductLoad(
      ProductDetailRequestedEvent event, Emitter<ProductState> emit) async {
    emit(ProductDetailLoading());

    await Future.delayed(Duration(milliseconds: 300));
    try {
      final productDetail = await getProductDetail(event.productId);

      emit(ProductDetailLoaded(product: productDetail));

      print("✅ โหลดสำเร็จ: ${productDetail}");
    } catch (e) {
      print("❌ ${event.productId} ล้มเหลว: $e");
      emit(ProductDetailError(message: "Fail to load : ${e.toString()}"));
    }
  }
}
