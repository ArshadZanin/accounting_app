import 'package:accounting_app/core/google_sheets_api.dart';
import 'package:accounting_app/models/transaction_model.dart';
import 'package:get/get.dart';

class TransactionsController extends GetxController {
  Future<void> onInit() async {
    super.onInit();
  }

  Future<void> initialize() async {
    var datas = await GoogleSheetsApi.fetchDatas();
    transactionList = datas?.map((e) => Transaction.fromJson(e)).toList() ?? [];
    transactionList.sort((a, b) => b.no!.compareTo(a.no!));
    update();
  }

  List<Transaction> transactionList = [];
}
