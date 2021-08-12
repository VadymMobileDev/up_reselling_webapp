import 'package:json_annotation/json_annotation.dart';

part 'domain_check.g.dart';

@JsonSerializable()
class DomainCheck {
  Domain domain;

  DomainCheck({required this.domain});

  factory DomainCheck.fromJson(Map<String, dynamic> json) => _$DomainCheckFromJson(json);

  Map<String, dynamic> toJson() => _$DomainCheckToJson(this);
}

@JsonSerializable()
class Domain {
  late String? name;
  Reselling reselling;
  late bool? premium;
  late bool? registered;
  late bool? protected;

  Domain(
      {required this.name,
      required this.reselling,
      required this.premium,
      required this.registered,
      required this.protected});

  factory Domain.fromJson(Map<String, dynamic> json) => _$DomainFromJson(json);

  Map<String, dynamic> toJson() => _$DomainToJson(this);
}

@JsonSerializable()
class Reselling {
  late int? price;
  late bool? availableForFree;
  late bool? test;

  Reselling({required this.price, required this.availableForFree, required this.test});

  factory Reselling.fromJson(Map<String, dynamic> json) => _$ResellingFromJson(json);

  Map<String, dynamic> toJson() => _$ResellingToJson(this);
}
