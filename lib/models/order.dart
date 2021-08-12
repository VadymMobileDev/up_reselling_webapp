import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class OrderParent {
  Order order;

  OrderParent({required this.order});

  factory OrderParent.fromJson(Map<String, dynamic> json) => _$OrderParentFromJson(json);
  Map<String, dynamic> toJson() => _$OrderParentToJson(this);
}



@JsonSerializable()
class Order {
  late int? orderNumber;
  late int? subtotal;
  late bool? test;

  Order({required this.orderNumber, required this.subtotal, required this.test});

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
