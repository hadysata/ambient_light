import 'dart:async';

import 'package:ambient_light/utils/numbers/random_numbers_utils.dart';
import 'package:ambient_light/widgets/particles/particle.dart';
import 'package:flutter/material.dart';

class ParticlesGenerator extends StatefulWidget {
  const ParticlesGenerator({super.key});

  @override
  State<ParticlesGenerator> createState() => _ParticlesGeneratorState();
}

class _ParticlesGeneratorState extends State<ParticlesGenerator> {
  List<Widget> particles = [];

  @override
  void didChangeDependencies() {
    particles = [];
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // Repeat every 200 milliseconds
    Timer.periodic(const Duration(milliseconds: 200), (timer) {
      setState(() {
        particles.add(
          Particle(
            size: getRandomNumber(0.04, 0.08),
          ),
        );
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: particles,
    );
  }
}
