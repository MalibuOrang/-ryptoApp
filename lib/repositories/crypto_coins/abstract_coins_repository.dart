import 'package:crypto_currency_list/repositories/crypto_coins/crypto_coin.dart';

abstract class AbstractCoinsRepository {
  Future<List<CryptoCoin>> getCoinsList();
  Future<CryptoCoin> getCoinsDetails(String currentCoin);
}
