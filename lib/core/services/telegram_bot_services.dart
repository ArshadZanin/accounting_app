import 'package:flutter/material.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

class TelegramBotServices {
  static var BOT_TOKEN = '5627897152:AAFl8vVn9v5rGtknm0d2FIYFcbyrYrkOUVo';
  static late TeleDart teledart;
  static Future<void> telegramInit() async {
    final username = (await Telegram(BOT_TOKEN).getMe()).username;
    teledart = TeleDart(BOT_TOKEN, Event(username!));
    teledart.start();
    debugPrint('telegram inited');
  }

  static Future<void> sendMessage(String text) async {
    teledart.sendMessage('-1001692514572', text);
  }
}
