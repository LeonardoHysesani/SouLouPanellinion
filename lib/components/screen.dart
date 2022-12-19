import 'package:flutter/material.dart';

class Screen extends StatefulWidget {
  const Screen({Key? key, required this.body}) : super(key: key);

  final Widget body;

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("pexels-cliford-mervil-2469122.jpg"), fit: BoxFit.fitHeight)),
          ),
          SafeArea(child: widget.body),
        ],
      ),
    );
  }
}
