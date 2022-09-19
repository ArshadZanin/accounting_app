import 'package:accounting_app/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi {
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "al-ramool-gifts",
  "private_key_id": "fc87979569f8cf5856520c3be369859669f1fd0f",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCRtKhqoerWLQ4Z\nExFveoB4Xy6FpFjxYcY+n9WunYFmK6yRlpkRW16O+RUScgWIRKAozPiVCDQcNYCX\nkhfmm9A3yqy44m8GqtwByOZKNQin8OCowwa//TQaWpoHB/oHDaqqqhYitOzM0qrP\net1k2W4aC4cxVgG62XAWwoAIqh/31kCyK+Dc4A59A99C+GSJAliaHykKxn/2EEYm\nrZybGyptrlD7LLcl0qkhDEXZDE27DGJnFj6n0KsIxmVyrFgcnmlzgI2uMS5FMyDH\nkXVBfxokHS1vj1XGwBujttBfF7G7irNIzzO6ECIVO7DcMLveiLGHwXFV9dD4jFag\nBYbMLHlPAgMBAAECggEAAvyonTL/jO90hAgTie0BeDY/TmcNmbku5rbBGyjIb89C\nZOOo9KWiXRz3FR84RNBfVibJi8iUxOVF4xWQHt6f2JzziIC/1OuowfKb4faPXF4A\nRQVmfIYUzNuBn9ZGhmF916zP8lsyJYrGDKXQpxIcAzWsSlMgivONLDJFjKfsKtj2\nI2QPDa9c7+RU4Ud6ij+MbCI+6RpgwcxToO+sup0zCf/1mQM0XuDS2lInn0La6s9X\njISsWsrmXfU3OuEOa6KTbuS21fNj4Qtta/jfvHgZ8zwuCmrUG75pz1aR+FguNIc2\n/CwTzT1cE3ENsZxEBC3YRUsLIn9LOw29YU3pqy3Q/QKBgQDHX62sqEIx+ty97zlt\nQ2Iq2LRybg1+YgK1ceWz3CyKaF9x1XTWt1m7M43MmLvz81ffc/gf2OoD0MXi74sa\nVOKvlSqq7TCuaT/ULdHvmJWcsB8OQHOMYoiArMwZ6r5mJGxSXAnrI/geue47ZuyY\nM3HQmRu30DK6jYbWHSaSTZKFhQKBgQC7FtBvg7WoDzOni+OV2/NR7Lv5JFZUVmUi\ntd3KZNEoCIw1kNfpLlD3PKo3DVjLyoORXNQ2WOdijbt++BI57svQdESY+xNlYrQ8\nCsgOmQhHXm+ipJsRNsSBMVelm3pAHiLzADHOGXH8iOn3qm/AHjTN2enDhLpHau6N\nvu7GjiJBwwKBgF/e2ErAFiSmduM2V6z8zAXCcvLbjM2LH7ZUcJpOc3SSv+KjPC3L\nuPBV2AfcIfUqvMSMpXHbApyXFbEMcx1UWDUKS5wptlEH91N2PQ8zli3kWuqlf2qw\nLueBMBv+T1Qai6QG8hYKE9PioHYcBgUiJ8ag+T0odlxSldX76oJLnvtpAoGAIBEj\n/skjfL/GScR3aLs/dF5QRb7NsTzxrsZfUo5/Lw5wAcpmx4fxxr62KiN2gc+fR24S\nzZHlbwX+CiA494cPlhYnn9UBGRKW8+ehLKdcPOdZ2RW/om6xtbcgX7lLdev0b5Qr\n9Th1SiSpfZLP/qzuvg3IvINmblFMvCzqvkukYYMCgYAZr+MT1J6TU82oLWej26hz\nqo2LpS5/hAPtwYHw0H+W+oyrKHvuH15Ri3bb2weUJsNIN4C9i5P+6fuuV4sMlt33\nwm6KpppqQIHUEyYupcDZsNz+CTzRK3WhOybZBbdAFC0fOchBcL14GFXtQRziko51\nQzlFlUcI6jQEP7o2L5MaFg==\n-----END PRIVATE KEY-----\n",
  "client_email": "al-ramool-gifts@al-ramool-gifts.iam.gserviceaccount.com",
  "client_id": "115812468944686107523",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/al-ramool-gifts%40al-ramool-gifts.iam.gserviceaccount.com"
}
''';
  static final _spreadsheetId = '1eJMODZrLT5WlPuPs8zd3URX09-_NoqEmhRuQnnQFZXo';
  static final _gsheets = GSheets(_credentials);

  static Worksheet? _transactionSheet;

  static Future<bool> initializeSheets() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _transactionSheet =
          await _getWorkSheet(spreadsheet, title: 'transaction');
      final firstRow = TransactionFields.getFields();
      await _transactionSheet!.values.insertRow(1, firstRow);
      debugPrint('Init Completed');
      return true;
    } catch (e) {
      debugPrint('Init Error: $e');
      return false;
    }
  }

  static Future<Worksheet> _getWorkSheet(Spreadsheet spreadsheet,
      {required String title}) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return await spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future insertRow(List<Map<String, dynamic>> rowList) async {
    if (_transactionSheet == null) return;
    _transactionSheet!.values.map.appendRows(rowList);
  }

  static Future<List<Map<String, String>>?> fetchDatas() async {
    if (_transactionSheet == null) return null;
    List<Map<String, String>>? values =
        await _transactionSheet!.values.map.allRows();
    return values;
  }
}
