import 'package:crypto_currency_list/repositories/crypto_coins/crypto_coin.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
part 'crypto_coin_model.g.dart';

@HiveType(typeId: 2)
class CryptoCoin extends Equatable {
  const CryptoCoin({required this.name, required this.detail});
  @HiveField(0)
  final String name;
  @HiveField(1)
  final CryptoCoinDetail detail;
  @override
  List<Object?> get props => [name, detail];
}
