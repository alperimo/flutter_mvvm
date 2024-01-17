import 'package:flutter/material.dart' as material;

class CircularProgressIndicator extends material.StatelessWidget{
  const CircularProgressIndicator({super.key});

  @override
  material.Widget build(material.BuildContext context) {
    return const material.CircularProgressIndicator(
        color: material.Colors.white
    );
  }
}