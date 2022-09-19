import 'package:accounting_app/core/google_sheets_api.dart';
import 'package:accounting_app/core/services/telegram_bot_services.dart';
import 'package:accounting_app/views/transactions.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  void onInit() async {
    await initialize();
    super.onInit();
  }

  Future<void> initialize() async {
    bool initialized = await GoogleSheetsApi.initializeSheets();
    await TelegramBotServices.telegramInit();
    if (initialized) {
      Get.off(Transactions());
    }
  }
}
