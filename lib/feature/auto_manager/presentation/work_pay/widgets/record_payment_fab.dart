import 'package:automanager/core/core.dart';
import 'package:flutter/material.dart';

class RecordPaymentFab extends StatelessWidget {
  final VoidCallback onTap;
  final bool isLoading;

  const RecordPaymentFab({super.key, required this.onTap, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: AppButton(
          onPressed: onTap,
          text: 'Record payment',
          loading: isLoading,
        ),
      ),
    );
  }
}
