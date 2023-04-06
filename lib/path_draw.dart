import 'package:flutter/material.dart';

class PathDraw extends StatefulWidget {
  const PathDraw({super.key});

  @override
  State<PathDraw> createState() => _PathDrawState();
}

class _PathDrawState extends State<PathDraw> {
  @override
  Widget build(BuildContext context) {
    return buildBody();
  }

  Widget buildBody() {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: const []),
      ),
    );
  }
}
