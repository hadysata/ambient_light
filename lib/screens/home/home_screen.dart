import 'package:ambient_light/constants/assets.dart';
import 'package:ambient_light/screens/home/controllers/home_screen_controller.dart';
import 'package:ambient_light/widgets/particles/particles_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeState();
}

class _HomeState extends ConsumerState<HomeScreen> {
  late final HomeScreenController controller;

  @override
  void initState() {
    super.initState();

    controller = HomeScreenController(ref: ref);
    controller.setupCamera(debug: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              const Image(image: AssetImage(Assets.assetsImagesDarkJPG)),
              AnimatedOpacity(
                opacity: controller.opacityInverse,
                duration: const Duration(milliseconds: 900),
                child: const ParticlesGenerator(),
              ),
            ],
          ),
          AnimatedOpacity(
            opacity: controller.opacity,
            duration: const Duration(milliseconds: 900),
            child: const Image(image: AssetImage(Assets.assetsImagesLightJPG)),
          ),
        ],
      ),
    );
  }
}
