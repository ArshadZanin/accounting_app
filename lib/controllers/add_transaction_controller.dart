import 'package:accounting_app/models/item_model.dart';
import 'package:accounting_app/models/transaction_model.dart';
import 'package:get/get.dart';

class AddTransactionController extends GetxController {
  Transaction transaction = Transaction(
    items: [
    ],
  );
}
