
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'item_model.g.dart';

@CopyWith()
@JsonSerializable()
class Items extends Equatable{
  num? sn;
  String? description;
  num? qty;
  num? unitPrice;
  num? netAmount;
  num? vat;
  num? amount;

  Items({
    this.sn,
    this.description,
    this.qty,
    this.unitPrice,
    this.netAmount,
    this.vat,
    this.amount,
  });

   factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);
  Map<String, dynamic> toJson() => _$ItemsToJson(this);
  
  @override
  List<Object?> get props => [sn ?? ''];
}
