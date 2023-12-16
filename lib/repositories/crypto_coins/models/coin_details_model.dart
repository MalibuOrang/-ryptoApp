import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';
part 'coin_details_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class CryptoCoinDetail extends Equatable {
  const CryptoCoinDetail(
      {required this.toSymbol,
      required this.lastUpdate,
      required this.priceInUSD,
      required this.imageUrl,
      required this.low24Hour,
      required this.hight24Hour});
  @HiveField(0)
  @JsonKey(name: 'TOSYMBOL')
  final String toSymbol;
  @HiveField(1)
  @JsonKey(
    name: 'LASTUPDATE',
    toJson: _dateTimeToJson,
    fromJson: _dateTimeFromJson,
  )
  final DateTime lastUpdate;
  @HiveField(2)
  @JsonKey(name: 'PRICE')
  final double priceInUSD;
  @HiveField(3)
  @JsonKey(name: 'IMAGEURL')
  final String imageUrl;
  @HiveField(4)
  @JsonKey(name: 'HIGH24HOUR')
  final double hight24Hour;
  @HiveField(5)
  @JsonKey(name: 'LOW24HOUR')
  final double low24Hour;
  String get fullImageUrl => 'https://www.cryptocompare.com/$imageUrl';
  factory CryptoCoinDetail.fromJson(Map<String, dynamic> json) =>
      _$CryptoCoinDetailFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoCoinDetailToJson(this);
  static int _dateTimeToJson(DateTime time) => time.microsecondsSinceEpoch;
  static DateTime _dateTimeFromJson(int milliseconds) =>
      DateTime.fromMicrosecondsSinceEpoch(milliseconds);
  @override
  List<Object?> get props =>
      [toSymbol, lastUpdate, priceInUSD, imageUrl, hight24Hour, low24Hour];
}
