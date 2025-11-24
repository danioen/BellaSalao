import 'package:flutter/material.dart';
import '../theme.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool enabled;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final child = Container(
      height: 52,
      decoration: BoxDecoration(
        gradient: enabled ? appGradient() : null,
        color: enabled ? null : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    );

    return SizedBox(
      width: double.infinity,
      child: enabled
          ? InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: onPressed,
              child: child,
            )
          : child,
    );
  }
}
