import 'package:equatable/equatable.dart';

class SaleInfo extends Equatable {
  final String? country;
  final String? saleability;
  final bool? isEbook;
  final Price? listPrice;
  final Price? retailPrice;

  const SaleInfo({
    this.country,
    this.saleability,
    this.isEbook,
    this.listPrice,
    this.retailPrice,
  });

  factory SaleInfo.fromJson(Map<String, dynamic> json) => SaleInfo(
    country: json['country'] as String?,
    saleability: json['saleability'] as String?,
    isEbook: json['isEbook'] as bool?,
    listPrice: json['listPrice'] != null
        ? Price.fromJson(json['listPrice'] as Map<String, dynamic>)
        : null,
    retailPrice: json['retailPrice'] != null
        ? Price.fromJson(json['retailPrice'] as Map<String, dynamic>)
        : null,
  );

  Map<String, dynamic> toJson() => {
    'country': country,
    'saleability': saleability,
    'isEbook': isEbook,
    'listPrice': listPrice?.toJson(),
    'retailPrice': retailPrice?.toJson(),
  };

  @override
  List<Object?> get props => [country, saleability, isEbook, listPrice, retailPrice];
}

class Price extends Equatable {
  final double? amount;
  final String? currencyCode;

  const Price({
    this.amount,
    this.currencyCode,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
    amount: (json['amount'] as num?)?.toDouble(),
    currencyCode: json['currencyCode'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'amount': amount,
    'currencyCode': currencyCode,
  };

  @override
  List<Object?> get props => [amount, currencyCode];
}
