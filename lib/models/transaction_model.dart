import 'dart:convert';

import 'package:accounting_app/models/item_model.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'transaction_model.g.dart';

@CopyWith()
@JsonSerializable()
class Transaction extends Equatable {
  String? no;
  String? date;
  String? tnr;
  String? cusTnr;
  String? name;
  String? LpnNo;
  String? total;
  String? grandTotal;

  @JsonKey(fromJson: itemsFromJson, toJson: itemsToJson)
  List<Items>? items;

  Transaction({
    this.no,
    this.date,
    this.tnr,
    this.cusTnr,
    this.name,
    this.LpnNo,
    this.total,
    this.grandTotal,
    this.items,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  @override
  List<Object?> get props => [no ?? ''];
}

List<Items>? itemsFromJson(json) {
  if (json != null) {
    List<dynamic> listJson = jsonDecode(json);
    List<Items> items = listJson.map((e) => Items.fromJson(e)).toList();
    return items;
  }
  return null;
}

String? itemsToJson(data) {
  if (data != null) {
    return jsonEncode(data);
  }
  return null;
}

class TransactionFields {
  static final String no = 'no';
  static final String date = 'date';
  static final String tnr = 'tnr';
  static final String cusTnr = 'cusTnr';
  static final String name = 'name';
  static final String LpnNo = 'LpnNo';
  static final String total = 'total';
  static final String grandTotal = 'grandTotal';
  static final String items = 'items';

  static List<String> getFields() =>
      [no, date, tnr, cusTnr, name, LpnNo, total, grandTotal, items];
}
