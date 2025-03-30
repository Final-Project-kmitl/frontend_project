import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project/core/common/helper/navigation/app_navigation.dart';
import 'package:project/core/config/assets/svg_assets.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/camera/presentation/bloc/camera_bloc.dart';
import 'package:project/features/product/presentation/pages/product_page.dart';

class BarcodeLoading extends StatefulWidget {
  final String barcodeInt;
  const BarcodeLoading({super.key, required this.barcodeInt});

  @override
  State<BarcodeLoading> createState() => _BarcodeLoadingState();
}

class _BarcodeLoadingState extends State<BarcodeLoading> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context
        .read<CameraBloc>()
        .add(SearchBarcodeEvent(barcode: widget.barcodeInt));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocListener<CameraBloc, CameraPhotoState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is BarcodeLoaded && mounted) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ProductPage(productId: state.productId)));
          }
        },
        child: BlocBuilder<CameraBloc, CameraPhotoState>(
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(SvgAssets.logoPath),
                  SizedBox(
                    height: 52,
                  ),
                  Text(
                    "กำลังค้นหาสินค้า",
                    style:
                        TextThemes.headline1.copyWith(color: AppColors.black),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  CircularProgressIndicator(
                    color: AppColors.black,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
