import 'package:json_annotation/json_annotation.dart';

part 'currency_domain.g.dart';

@JsonSerializable()
class CurrencyDomain {
  late int USD;
  late double XRP;

  CurrencyDomain({required this.USD, required this.XRP});

  factory CurrencyDomain.fromJson(Map<String, dynamic> json) => _$CurrencyDomainFromJson(json);
  Map<String, dynamic> toJson() => _$CurrencyDomainToJson(this);
}