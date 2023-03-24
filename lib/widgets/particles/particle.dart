import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:ambient_light/utils/numbers/random_numbers_utils.dart';

class Particle extends ConsumerStatefulWidget {
  final double size;

  const Particle({
    super.key,
    this.size = 3,
  });

  @override
  ConsumerState<Particle> createState() => _ParticleState();
}

class _ParticleState extends ConsumerState<Particle> {
  StateProvider<double> blurProvider = StateProvider<double>((ref) {
    return getRandomNumber(1.2, 2.0);
  });

  @override
  void initState() {
    super.initState();

    // Repeat the function every 100 milliseconds
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (ref.read(blurProvider) > 0.9) {
        ref.watch(blurProvider.notifier).state -= 0.01;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: getRandomNumber(0, 360).w,
      bottom: getRandomNumber(0, 700).w,
      child: Opacity(
        opacity: getRandomNumber(0.2, 1),
        child: SizedBox(
          child: Consumer(builder: (context, ref, _) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 255, 255, 204),
                    blurRadius: widget.size.r,
                    spreadRadius: 4,
                  ),
                ],
              ),
              height: widget.size.r,
              width: widget.size.r,
            ).blur(blur: ref.watch(blurProvider));
          }),
        )
            .animate()
            .fadeOut(
              delay: getRandomNumber(1500, 1800).milliseconds,
              duration: 1000.ms,
            )
            .animate()
            .scale(
              duration: 300.ms,
              alignment: Alignment.center,
            )
            .fadeIn(
              duration: 1200.ms,
            )
            .slideY(
              end: -6500,
              duration: 23.seconds,
            ),
      ),
    );
  }
}
