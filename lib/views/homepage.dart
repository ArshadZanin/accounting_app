import 'package:accounting_app/controllers/homepage_controller.dart';
import 'package:accounting_app/controllers/transactions_controller.dart';
import 'package:accounting_app/models/transaction_model.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeInUp(
            child: Image.asset(
          'assets/images/balloons.png',
          height: 50,
          width: 50,
        )),
      ),
    );
  }
}
