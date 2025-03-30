import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/core/common/helper/navigation/app_navigation.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/camera/presentation/bloc/camera_bloc.dart';
import 'package:project/features/camera/presentation/pages/crop_page.dart';
import 'package:project/features/camera/presentation/pages/show_img.dart';

class TakePhotoUI extends StatefulWidget {
  final PhotoCameraState state;

  const TakePhotoUI(this.state, {super.key});

  @override
  _TakePhotoUIState createState() => _TakePhotoUIState();
}

class _TakePhotoUIState extends State<TakePhotoUI> {
  Offset? _focusPosition;
  List<XFile> path = [];
  GlobalKey _previewKey = GlobalKey();
  bool _isNewState = false;

  Future<void> _takePhoto() async {
    try {
      final CaptureRequest photo = await widget.state.takePhoto();

      // Crop the image
      // final croppedImagePath = await _cropImage(photo.path!);
      final croppedImagePath = await Navigator.push<String>(
        context,
        MaterialPageRoute(
          builder: (context) => CropPage(imagePath: photo.path!),
        ),
      );

      setState(() {
        path.add(XFile(croppedImagePath!));
        _isNewState = false;
      });

      print("Cropped PATH : ${path}");
    } catch (e) {
      print('Error taking photo: $e');
    }
  }

  // Future<String> _cropImage(String originalImagePath) async {
  //   // Read the original image
  //   File originalImage = File(originalImagePath);
  //   img.Image? image = img.decodeImage(await originalImage.readAsBytes());

  //   if (image == null) {
  //     throw Exception('Failed to decode image');
  //   }

  //   // Calculate crop dimensions based on MyPint's rectangle
  //   final Size screenSize = MediaQuery.of(context).size;
  //   final double cropWidth = screenSize.width * 0.65;
  //   final double cropHeight = screenSize.height * 0.7;

  //   // Calculate the crop area
  //   final int sourceWidth = image.width;
  //   final int sourceHeight = image.height;

  //   // Calculate the crop rectangle
  //   final double widthRatio = sourceWidth / screenSize.width;
  //   final double heightRatio = sourceHeight / screenSize.height;

  //   final int cropX = ((sourceWidth - cropWidth * widthRatio) / 2).toInt();
  //   final int cropY = ((sourceHeight - cropHeight * heightRatio) / 2).toInt();
  //   final int cropWidthPixels = (cropWidth * widthRatio).toInt();
  //   final int cropHeightPixels = (cropHeight * heightRatio).toInt();

  //   // Crop the image
  //   img.Image croppedImage = img.copyCrop(image,
  //       x: cropX, y: cropY, width: cropWidthPixels, height: cropHeightPixels);

  //   // Save the cropped image
  //   final Directory tempDir = await getTemporaryDirectory();
  //   final String croppedImagePath =
  //       '${tempDir.path}/cropped_${DateTime.now().millisecondsSinceEpoch}.jpg';

  //   File croppedFile = File(croppedImagePath);
  //   await croppedFile.writeAsBytes(img.encodeJpg(croppedImage));

  //   return croppedImagePath;
  // }

  @override
  Widget build(BuildContext context) {
    final Size previewSize = MediaQuery.of(context).size;

    return Stack(
      key: _previewKey,
      children: [
        GestureDetector(
          onTapDown: (TapDownDetails details) {
            final double x = details.localPosition.dx;
            final double y = details.localPosition.dy;

            final RRect focusRegion = RRect.fromRectAndRadius(
              Rect.fromCenter(
                center:
                    Offset(previewSize.width * 0.5, previewSize.height * 0.5),
                width: previewSize.width * 0.8,
                height: previewSize.height * 0.5,
              ),
              const Radius.circular(15),
            );
            if (focusRegion.contains(Offset(x, y))) {
              setState(() {
                _focusPosition = Offset(x, y);
              });

              Future.delayed(const Duration(seconds: 3), () {
                setState(() {
                  _focusPosition = null;
                });
              });
            }
          },
          child: Container(
            child: CustomPaint(
              size: previewSize,
              painter: MyPint(),
            ),
          ),
        ),
        if (_focusPosition != null)
          Positioned(
            child: AwesomeFocusIndicator(
              position: _focusPosition!,
            ),
          ),
        Positioned(
          bottom: 100,
          left: 0,
          right: 0,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                path.length < 3
                    ? _takePhoto()
                    : ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Container(
                            padding: EdgeInsets.all(8),
                            child: Text("ไม่สามารถถ่ายรูปได้เกิน 3 รูป"),
                          ),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: AppColors.white,
                      width: 3), // Border with thickness 3
                ),
                child: Container(
                  width: 68,
                  height: 68,
                  margin: EdgeInsets.all(
                      3), // Adds the 3px gap between the circle and the border
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        if (path.isNotEmpty)
          Positioned(
            bottom: 110,
            left: 40,
            right: 0,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: GestureDetector(
                onTap: () {
                  AppNavigator.push(
                      context,
                      ShowImg(
                        photoPaht: path,
                        fn: (value) {
                          setState(() {
                            path.removeAt(value);
                          });
                        },
                      ));
                },
                child: Container(
                  width: 70,
                  height: 70,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(4), // 🟢 ทำให้รูปมีขอบมน
                    child: Image.file(
                      File(path.last.path),
                      fit: BoxFit.cover, // 🟢 ปรับให้รูปพอดีกับ Container
                    ),
                  ),
                ),
              ),
            ),
          ),
        if (path.isNotEmpty)
          Positioned(
            bottom: 125,
            left: 0,
            right: 40,
            child: Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () async {
                  if (!_isNewState) {
                    context.read<CameraBloc>().add(SearchByPhoto(imgs: path));
                    setState(() {
                      _isNewState = true;
                    });
                  }

                  if (!mounted) return;

                  await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder:
                          (context) =>
                              StatefulBuilder(builder: (context, setState) {
                                return DraggableScrollableSheet(
                                    initialChildSize:
                                        0.5, // เริ่มต้นที่ 50% ของหน้าจอ
                                    minChildSize: 0.3, // ต่ำสุดที่ 30%
                                    maxChildSize: 0.6, // สูงสุดไม่เกิน 80%
                                    expand: false, // ไม่บังคับให้เต็มจอ
                                    builder: (context, scrollController) {
                                      return Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.white,
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20),
                                            ),
                                          ),
                                          child: Stack(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 36),
                                                child: SingleChildScrollView(
                                                  controller: scrollController,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "ผลการค้นหา",
                                                        style: TextThemes
                                                            .headline2,
                                                      ),
                                                      BlocBuilder<CameraBloc,
                                                          CameraPhotoState>(
                                                        builder:
                                                            (context, state) {
                                                          if (state
                                                              is PhotoLoading) {
                                                            return Center(
                                                              child: Text(
                                                                  "กำลังค้นหา"),
                                                            );
                                                          }

                                                          if (state
                                                                  is PhotoLoaded &&
                                                              state.res
                                                                      .matchingProducts ==
                                                                  []) {
                                                            return Container(
                                                              child: Text(
                                                                  "no product"),
                                                            );
                                                          }

                                                          if (state
                                                              is PhotoLoaded) {
                                                            return ListView
                                                                .separated(
                                                              separatorBuilder:
                                                                  (context,
                                                                      index) {
                                                                return SizedBox(
                                                                    height: 12);
                                                              },
                                                              shrinkWrap: true,
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                              itemCount: state
                                                                      .res
                                                                      .matchingProducts!
                                                                      .length +
                                                                  1,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                if (index ==
                                                                    state
                                                                        .res
                                                                        .matchingProducts!
                                                                        .length) {
                                                                  return SizedBox(
                                                                      height:
                                                                          100);
                                                                }
                                                                return Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              12),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: AppColors
                                                                        .paleBlue,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            16),
                                                                  ),
                                                                  child: Row(
                                                                    // Removed the expanded here
                                                                    children: [
                                                                      Container(
                                                                        padding:
                                                                            EdgeInsets.all(12),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              AppColors.white,
                                                                          borderRadius:
                                                                              BorderRadius.circular(8),
                                                                        ),
                                                                        width:
                                                                            100,
                                                                        height:
                                                                            100,
                                                                        child: Image
                                                                            .network(
                                                                          fit: BoxFit
                                                                              .contain,
                                                                          state
                                                                              .res
                                                                              .matchingProducts![index]
                                                                              .image!,
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                          width:
                                                                              16),
                                                                      Expanded(
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          children: [
                                                                            Text(
                                                                              state.res.matchingProducts![index].brand!,
                                                                              style: TextThemes.desc.copyWith(color: AppColors.darkGrey),
                                                                            ),
                                                                            Text(
                                                                              //removed expanded here
                                                                              state.res.matchingProducts![index].name!,
                                                                              style: TextThemes.bodyBold,
                                                                              maxLines: 1,
                                                                              softWrap: false,
                                                                              overflow: TextOverflow.ellipsis,
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                Container(
                                                                                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                                                                  decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.circular(4),
                                                                                      color: state.res.matchingProducts![index].rating! > 75
                                                                                          ? AppColors.quality_good_match
                                                                                          : state.res.matchingProducts![index].rating! > 50
                                                                                              ? AppColors.quality_medium_match
                                                                                              : state.res.matchingProducts![index].rating! > 25
                                                                                                  ? AppColors.quality_poor_match
                                                                                                  : AppColors.quality_not_math),
                                                                                  child: Text(
                                                                                    "${state.res.matchingProducts![index].rating!.toString()}/100",
                                                                                    style: TextThemes.descBold.copyWith(color: AppColors.white),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 12,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Expanded(
                                                                                child: Row(
                                                                              children: [
                                                                                Text("ดูรายละเอียด")
                                                                              ],
                                                                            ))
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          }
                                                          return Container(
                                                            child: Center(
                                                              child:
                                                                  Text("data"),
                                                            ),
                                                          );
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                left: 0,
                                                right: 0,
                                                child: Container(
                                                  width: double
                                                      .infinity, // ✅ กำหนดขนาดที่แน่นอน
                                                  padding: EdgeInsets.only(
                                                      bottom: 52,
                                                      left: 20,
                                                      right: 20),
                                                  child: SizedBox(
                                                    // ✅ ใช้ SizedBox เพื่อกำหนดความสูง
                                                    height:
                                                        100, // หรือใช้ constraints
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize
                                                          .min, // ✅ ป้องกันการขยายเกินขนาด
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                                child:
                                                                    Divider()),
                                                            SizedBox(width: 4),
                                                            Text(
                                                              "ไม่ใช่ผลิตภัณฑ์ที่คุณตามหา?",
                                                              style: TextThemes
                                                                  .desc
                                                                  .copyWith(
                                                                      color: AppColors
                                                                          .grey),
                                                            ),
                                                            SizedBox(width: 4),
                                                            Expanded(
                                                                child:
                                                                    Divider()),
                                                          ],
                                                        ),
                                                        SizedBox(height: 16),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                        color: AppColors
                                                                            .grey),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            16)),
                                                                height: 50,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Icon(Icons
                                                                        .flag_outlined),
                                                                    SizedBox(
                                                                      width: 8,
                                                                    ),
                                                                    Text(
                                                                      "รายงาน",
                                                                      style: TextThemes
                                                                          .bodyBold,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(width: 16),
                                                            Expanded(
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                        color: AppColors
                                                                            .grey),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            16)),
                                                                height: 50,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Icon(Icons
                                                                        .show_chart),
                                                                    SizedBox(
                                                                      width: 8,
                                                                    ),
                                                                    Text(
                                                                      "วิเคราะห์ต่อไป",
                                                                      style: TextThemes
                                                                          .bodyBold,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ), // ✅ กำหนด height
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ));
                                    });
                              }));

                  // สามารถ refresh state หลังปิด BottomSheet ได้ถ้าจำเป็น
                  setState(() {});
                },
                child: Container(
                  child: Text(
                    "ประมวลผล (${path.length})",
                    style: TextThemes.descBold,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      border: Border.all(color: AppColors.transparent),
                      borderRadius: BorderRadius.circular(1000)),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class MyPint extends CustomPainter {
  Rect? cropRect;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black54;

    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
        Path()
          ..addRRect(
            RRect.fromRectAndRadius(
              Rect.fromCenter(
                center: Offset(size.width * 0.5, size.height * 0.5),
                width: size.width * 0.8,
                height: size.height * 0.5,
              ),
              Radius.circular(28),
            ),
          )
          ..close(),
      ),
      paint,
    );

    final borderPaint = Paint()
      ..color = Colors.white70
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final borderRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(size.width * 0.5, size.height * 0.5),
        width: size.width * 0.8,
        height: size.height * 0.5,
      ),
      const Radius.circular(28),
    );

    canvas.drawRRect(borderRect, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class AwesomeFocusIndicator extends StatelessWidget {
  final Offset position;

  const AwesomeFocusIndicator({required this.position, super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx - 40,
      top: position.dy - 40,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
        ),
      ),
    );
  }
}
