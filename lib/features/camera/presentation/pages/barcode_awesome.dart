import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/features/camera/presentation/pages/utils/mlkit_utils.dart';
import 'package:project/features/camera/presentation/widgets/barcode_loading.dart';
import 'package:project/features/camera/presentation/widgets/barcode_preview_overlay.dart';

class BarcodeAwesome extends StatefulWidget {
  const BarcodeAwesome({super.key});

  @override
  State<BarcodeAwesome> createState() => _BarcodeAwesomeState();
}

class _BarcodeAwesomeState extends State<BarcodeAwesome>
    with WidgetsBindingObserver {
  final _barcodeScanner = BarcodeScanner(formats: [BarcodeFormat.all]);
  List<Barcode> _barcodes = [];
  AnalysisImage? _image;
  bool _isDisposed = false; // Add this line
  String? _readFromPreview;
  bool? _inAreaFromPreview;
  bool _isNavigating = false; // Add this line

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _isDisposed = true; // Add this line
    _barcodeScanner.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Stop camera and barcode scanning when app is in background
      _barcodeScanner.close();
    }
  }

  void _stopCameraAndScanner() {
    _barcodeScanner.close();
  }

  void _checkAndNavigate() {
    if (_readFromPreview != null &&
        _inAreaFromPreview == true &&
        !_isNavigating) {
      _isNavigating = true;
      _stopCameraAndScanner(); // Stop camera before navigation

      if (mounted) {
        Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        BarcodeLoading(barcodeInt: _readFromPreview!)))
            .then((value) {
          _isNavigating = false;
          // Optionally reinitialize scanner if needed
          // _barcodeScanner = BarcodeScanner(formats: [BarcodeFormat.all]);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      extendBodyBehindAppBar: true,
      body: CameraAwesomeBuilder.awesome(
        saveConfig: SaveConfig.photo(),
        sensorConfig: SensorConfig.single(
          zoom: 0.02,
          aspectRatio: CameraAspectRatios.ratio_16_9,
        ),
        previewFit: CameraPreviewFit.fitHeight,
        previewDecoratorBuilder: (state, preview) {
          return BarcodePreviewOverlay(
            state: state,
            barcodes: _barcodes,
            analysisImage: _image,
            preview: preview,
            onBarcodeReadChanged: (read) {
              setState(() {
                _readFromPreview = read;
                _checkAndNavigate();
              });
            },
            onBarcodeInAreaChanged: (inArea) {
              setState(() {
                _inAreaFromPreview = inArea;
                _checkAndNavigate();
              });
            },
          );
        },
        topActionsBuilder: (state) {
          return AwesomeTopActions(
            state: state,
            children: [],
          );
        },
        middleContentBuilder: (state) {
          return const SizedBox.shrink();
        },
        bottomActionsBuilder: (state) {
          return const Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text(""),
          );
        },
        onImageForAnalysis: (img) => _processImageBarcode(img),
        imageAnalysisConfig: AnalysisConfig(
          androidOptions: const AndroidAnalysisOptions.nv21(
            width: 128, // Reduce width
          ),
          maxFramesPerSecond: 2, // Reduce frames per second
        ),
      ),
    );
  }

  Future _processImageBarcode(AnalysisImage img) async {
    if (_isDisposed) return; // Add this line

    try {
      var recognizedBarCodes =
          await _barcodeScanner.processImage(img.toInputImage());

      if (recognizedBarCodes.isNotEmpty) {
        if (!mounted) return;
        setState(() {
          _barcodes = recognizedBarCodes;
          _image = img;
        });
      }
    } catch (error) {
      debugPrint("...sending image resulted error $error");
    }
  }
}
