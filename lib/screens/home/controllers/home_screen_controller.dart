import 'dart:developer';

import 'package:ambient_light/screens/home/providers/home_screen_providers.dart';
import 'package:ambient_light/utils/camera/camera_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreenController {
  final WidgetRef ref;

  const HomeScreenController({required this.ref});

  /// A getter that returns the opacity value from the [opacityProvider]
  double get opacity => ref.watch(HomeScreenProviders.opacityProvider);

  /// It's just a getter that returns the inverse of the opacity value.
  double get opacityInverse => (1.0 - opacity).abs();

  /// `setupCamera` initializes the front camera, starts the image stream, and then uses the
  /// `estimateAmbientLightLevel` function to estimate the ambient light level
  Future<void> setupCamera({bool debug = false}) async {
    final controller = await CameraUtils.initFrontCamera();

    controller.startImageStream((image) {
      final num estimatedAmbientLightLevel = CameraUtils.estimateOpacityByAmbientLightLevel(
          sensorExposureTime: image.sensorExposureTime,
          sensorSensitivity: image.sensorSensitivity,
          lensAperture: image.lensAperture);

      if (debug) {
        log("Estimated Ambient Light Level: $estimatedAmbientLightLevel");
      }

      ref.watch(HomeScreenProviders.opacityProvider.notifier).state = estimatedAmbientLightLevel.toDouble();
    });
  }
}
