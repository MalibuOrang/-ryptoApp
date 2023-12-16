import 'package:crypto_currency_list/repositories/crypto_coins/crypto_coin.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'crypto_coins_list_app.dart';

void main() async {
  const cryptoCoinsBoxName = 'crypto_coins_box';
  await Hive.initFlutter();
  Hive.registerAdapter(CryptoCoinAdapter());
  Hive.registerAdapter(CryptoCoinDetailAdapter());
  final cryptoCoinsBox = await Hive.openBox<CryptoCoin>(cryptoCoinsBoxName);
  GetIt.I.registerLazySingleton<AbstractCoinsRepository>(
      () => CryptoCoinsRepository(dio: Dio(), cryptoCoinsBox: cryptoCoinsBox));
  runApp(const CryptoCurrenciesRateApp());
}
