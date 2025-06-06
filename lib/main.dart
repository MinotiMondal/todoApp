
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_application/new/hello.dart';
import 'package:to_do_application/new/taskListPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do List',
      home: Hello(),
    );
  }
}
