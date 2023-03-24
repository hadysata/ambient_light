import 'package:camera/camera.dart';

class CameraUtils {
  /// It initializes the front camera.
  ///
  /// Returns:
  ///   A CameraController object.
  static Future<CameraController> initFrontCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras[1];
    final controller = CameraController(firstCamera, ResolutionPreset.ultraHigh);

// Start the camera preview and wait for it to initialize
    await controller.initialize();

    return controller;
  }

  /// "The higher the ambient light level, the more opaque the overlay."
  ///
  /// The function takes three parameters:
  ///
  /// * `sensorExposureTime`: The exposure time of the camera sensor in microseconds.
  /// * `sensorSensitivity`: The sensitivity of the camera sensor in ISO.
  /// * `lensAperture`: The aperture of the lens in f-stops
  ///
  /// Args:
  ///   sensorExposureTime (int): The time the sensor is exposed to light.
  ///   sensorSensitivity (double): The ISO value of the camera sensor.
  ///   lensAperture (double): The aperture of the lens.
  ///
  /// Returns:
  ///   The opacity of the image.
  static double estimateOpacityByAmbientLightLevel(
      {int? sensorExposureTime, double? sensorSensitivity, double? lensAperture}) {
    double ambientLightLevel =
        ((50 * lensAperture! * lensAperture) / (sensorExposureTime! * sensorSensitivity!)) * 100000000;

    if (ambientLightLevel >= 0.35) {
      ambientLightLevel *= 2;
    } else {
      ambientLightLevel /= 100;
    }

    double opacity = (1.0 - double.parse(ambientLightLevel.toStringAsFixed(3))).abs();

    if (opacity <= 0.25) {
      opacity = opacity / 3;
    }

    if (opacity <= 0.09) {
      opacity = 0.0;
    }

    return opacity > 1.0
        ? 1.0
        : opacity < 0.0
            ? 0.0
            : opacity;
  }
}
