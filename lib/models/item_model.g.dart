// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ItemsCWProxy {
  Items amount(num? amount);

  Items description(String? description);

  Items netAmount(num? netAmount);

  Items qty(num? qty);

  Items sn(num? sn);

  Items unitPrice(num? unitPrice);

  Items vat(num? vat);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Items(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Items(...).copyWith(id: 12, name: "My name")
  /// ````
  Items call({
    num? amount,
    String? description,
    num? netAmount,
    num? qty,
    num? sn,
    num? unitPrice,
    num? vat,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfItems.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfItems.copyWith.fieldName(...)`
class _$ItemsCWProxyImpl implements _$ItemsCWProxy {
  final Items _value;

  const _$ItemsCWProxyImpl(this._value);

  @override
  Items amount(num? amount) => this(amount: amount);

  @override
  Items description(String? description) => this(description: description);

  @override
  Items netAmount(num? netAmount) => this(netAmount: netAmount);

  @override
  Items qty(num? qty) => this(qty: qty);

  @override
  Items sn(num? sn) => this(sn: sn);

  @override
  Items unitPrice(num? unitPrice) => this(unitPrice: unitPrice);

  @override
  Items vat(num? vat) => this(vat: vat);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Items(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Items(...).copyWith(id: 12, name: "My name")
  /// ````
  Items call({
    Object? amount = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? netAmount = const $CopyWithPlaceholder(),
    Object? qty = const $CopyWithPlaceholder(),
    Object? sn = const $CopyWithPlaceholder(),
    Object? unitPrice = const $CopyWithPlaceholder(),
    Object? vat = const $CopyWithPlaceholder(),
  }) {
    return Items(
      amount: amount == const $CopyWithPlaceholder()
          ? _value.amount
          // ignore: cast_nullable_to_non_nullable
          : amount as num?,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      netAmount: netAmount == const $CopyWithPlaceholder()
          ? _value.netAmount
          // ignore: cast_nullable_to_non_nullable
          : netAmount as num?,
      qty: qty == const $CopyWithPlaceholder()
          ? _value.qty
          // ignore: cast_nullable_to_non_nullable
          : qty as num?,
      sn: sn == const $CopyWithPlaceholder()
          ? _value.sn
          // ignore: cast_nullable_to_non_nullable
          : sn as num?,
      unitPrice: unitPrice == const $CopyWithPlaceholder()
          ? _value.unitPrice
          // ignore: cast_nullable_to_non_nullable
          : unitPrice as num?,
      vat: vat == const $CopyWithPlaceholder()
          ? _value.vat
          // ignore: cast_nullable_to_non_nullable
          : vat as num?,
    );
  }
}

extension $ItemsCopyWith on Items {
  /// Returns a callable class that can be used as follows: `instanceOfItems.copyWith(...)` or like so:`instanceOfItems.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ItemsCWProxy get copyWith => _$ItemsCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Items _$ItemsFromJson(Map<String, dynamic> json) => Items(
      sn: json['sn'] as num?,
      description: json['description'] as String?,
      qty: json['qty'] as num?,
      unitPrice: json['unitPrice'] as num?,
      netAmount: json['netAmount'] as num?,
      vat: json['vat'] as num?,
      amount: json['amount'] as num?,
    );

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'sn': instance.sn,
      'description': instance.description,
      'qty': instance.qty,
      'unitPrice': instance.unitPrice,
      'netAmount': instance.netAmount,
      'vat': instance.vat,
      'amount': instance.amount,
    };
