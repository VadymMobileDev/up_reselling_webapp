import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class OrderParent {
  Order order;

  OrderParent({required this.order});

  factory OrderParent.fromJson(Map<String, dynamic> json) => _$OrderParentFromJson(json);
  Map<String, dynamic> toJson() => _$OrderParentToJson(this);

  // OrderParent.fromJson(Map<String, dynamic> json) {
  //   order = json['order'] != null ? new Order.fromJson(json['order']) : null;
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   if (this.order != null) {
  //     data['order'] = this.order.toJson();
  //   }
  //   return data;
  // }
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
