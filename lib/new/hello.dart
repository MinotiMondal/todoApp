import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Hello extends StatelessWidget {
  const Hello({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: List.generate(
            10, (index) => ListTile(title: Text('Item $index'))),
      ),
    );
  }
}
