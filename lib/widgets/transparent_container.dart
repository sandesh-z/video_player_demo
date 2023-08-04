import 'package:flutter/material.dart';

class TransparentContainer extends StatelessWidget {
  final Widget? child;
  const TransparentContainer({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black.withOpacity(.4),
      ),
      child: child,
    );
  }
}
