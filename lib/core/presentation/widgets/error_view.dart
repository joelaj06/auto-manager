import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text.rich(
          TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: 'Sorry an error occurred',
                style: theme.titleLarge!.copyWith(height: 1.5),
              ),
              TextSpan(text: '  —  ', style: theme.titleMedium),
              TextSpan(
                text: 'Please restart the application',
                style: theme.titleMedium!.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
