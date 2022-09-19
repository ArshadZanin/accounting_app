import 'package:accounting_app/core/google_sheets_api.dart';
import 'package:accounting_app/core/services/telegram_bot_services.dart';
import 'package:accounting_app/views/add_transaction.dart';
import 'package:accounting_app/views/homepage.dart';
import 'package:accounting_app/views/transactions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Al-Ramool App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
