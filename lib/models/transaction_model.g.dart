// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TransactionCWProxy {
  Transaction LpnNo(String? LpnNo);

  Transaction cusTnr(String? cusTnr);

  Transaction date(String? date);

  Transaction grandTotal(String? grandTotal);

  Transaction items(List<Items>? items);

  Transaction name(String? name);

  Transaction no(String? no);

  Transaction tnr(String? tnr);

  Transaction total(String? total);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Transaction(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Transaction(...).copyWith(id: 12, name: "My name")
  /// ````
  Transaction call({
    String? LpnNo,
    String? cusTnr,
    String? date,
    String? grandTotal,
    List<Items>? items,
    String? name,
    String? no,
    String? tnr,
    String? total,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTransaction.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTransaction.copyWith.fieldName(...)`
class _$TransactionCWProxyImpl implements _$TransactionCWProxy {
  final Transaction _value;

  const _$TransactionCWProxyImpl(this._value);

  @override
  Transaction LpnNo(String? LpnNo) => this(LpnNo: LpnNo);

  @override
  Transaction cusTnr(String? cusTnr) => this(cusTnr: cusTnr);

  @override
  Transaction date(String? date) => this(date: date);

  @override
  Transaction grandTotal(String? grandTotal) => this(grandTotal: grandTotal);

  @override
  Transaction items(List<Items>? items) => this(items: items);

  @override
  Transaction name(String? name) => this(name: name);

  @override
  Transaction no(String? no) => this(no: no);

  @override
  Transaction tnr(String? tnr) => this(tnr: tnr);

  @override
  Transaction total(String? total) => this(total: total);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Transaction(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Transaction(...).copyWith(id: 12, name: "My name")
  /// ````
  Transaction call({
    Object? LpnNo = const $CopyWithPlaceholder(),
    Object? cusTnr = const $CopyWithPlaceholder(),
    Object? date = const $CopyWithPlaceholder(),
    Object? grandTotal = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? no = const $CopyWithPlaceholder(),
    Object? tnr = const $CopyWithPlaceholder(),
    Object? total = const $CopyWithPlaceholder(),
  }) {
    return Transaction(
      LpnNo: LpnNo == const $CopyWithPlaceholder()
          ? _value.LpnNo
          // ignore: cast_nullable_to_non_nullable
          : LpnNo as String?,
      cusTnr: cusTnr == const $CopyWithPlaceholder()
          ? _value.cusTnr
          // ignore: cast_nullable_to_non_nullable
          : cusTnr as String?,
      date: date == const $CopyWithPlaceholder()
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as String?,
      grandTotal: grandTotal == const $CopyWithPlaceholder()
          ? _value.grandTotal
          // ignore: cast_nullable_to_non_nullable
          : grandTotal as String?,
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<Items>?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      no: no == const $CopyWithPlaceholder()
          ? _value.no
          // ignore: cast_nullable_to_non_nullable
          : no as String?,
      tnr: tnr == const $CopyWithPlaceholder()
          ? _value.tnr
          // ignore: cast_nullable_to_non_nullable
          : tnr as String?,
      total: total == const $CopyWithPlaceholder()
          ? _value.total
          // ignore: cast_nullable_to_non_nullable
          : total as String?,
    );
  }
}

extension $TransactionCopyWith on Transaction {
  /// Returns a callable class that can be used as follows: `instanceOfTransaction.copyWith(...)` or like so:`instanceOfTransaction.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TransactionCWProxy get copyWith => _$TransactionCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      no: json['no'] as String?,
      date: json['date'] as String?,
      tnr: json['tnr'] as String?,
      cusTnr: json['cusTnr'] as String?,
      name: json['name'] as String?,
      LpnNo: json['LpnNo'] as String?,
      total: json['total'] as String?,
      grandTotal: json['grandTotal'] as String?,
      items: itemsFromJson(json['items']),
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'no': instance.no,
      'date': instance.date,
      'tnr': instance.tnr,
      'cusTnr': instance.cusTnr,
      'name': instance.name,
      'LpnNo': instance.LpnNo,
      'total': instance.total,
      'grandTotal': instance.grandTotal,
      'items': itemsToJson(instance.items),
    };
