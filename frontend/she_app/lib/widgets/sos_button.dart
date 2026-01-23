import 'package:flutter/material.dart';

class SOSButton extends StatelessWidget {
  final AnimationController pulseController;
  final VoidCallback onLongPress;

  const SOSButton({
    super.key,
    required this.pulseController,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: AnimatedBuilder(
        animation: pulseController,
        builder: (context, child) {
          return Transform.scale(
            scale: pulseController.value,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 60,
                vertical: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.6),
                    blurRadius: 30,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: const Text(
                "HOLD TO TRIGGER SOS",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
