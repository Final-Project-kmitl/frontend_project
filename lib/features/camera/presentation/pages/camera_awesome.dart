import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:project/features/camera/presentation/pages/camera_state/takePhotoUI.dart';

class CameraAwesome extends StatefulWidget {
  const CameraAwesome({super.key});

  @override
  State<CameraAwesome> createState() => _CameraAwesomeState();
}

class _CameraAwesomeState extends State<CameraAwesome> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.black,
      body: CameraAwesomeBuilder.custom(
        builder: (cameraState, review) {
          return cameraState.when(
            onPreparingCamera: (state) => Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
              ),
            ),
            onPhotoMode: (state) => TakePhotoUI(state),
          );
        },
        saveConfig: SaveConfig.photo(),
        sensorConfig: SensorConfig.single(zoom: 0.02),
      ),
    );
  }
}
