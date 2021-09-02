import 'package:json_annotation/json_annotation.dart';

part 'order_send.g.dart';

@JsonSerializable()
class OrderSend {
  Order order;

  OrderSend({required this.order});

  factory OrderSend.fromJson(Map<String, dynamic> json) => _$OrderSendFromJson(json);
  Map<String, dynamic> toJson() => _$OrderSendToJson(this);
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
