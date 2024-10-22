import 'package:flutter/material.dart';
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){}
      ,child: const Icon(Icons.add),),
      body: const Center(
        child: Text('Onboarding Screen'),
      ),
    );
  }
}
