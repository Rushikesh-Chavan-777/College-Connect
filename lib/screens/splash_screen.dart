import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget{
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("College Connect"),
        backgroundColor: Colors.redAccent,
      ),
      body: const Center(
        child: Column(
          children: [
            Text("Loading", style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold),),
            CircularProgressIndicator(),
          ],
        ),
      )
    );
  }
}