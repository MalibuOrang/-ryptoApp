import 'package:crypto_currency_list/repositories/crypto_coins/crypto_coin.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CryptoCoinsRepository implements AbstractCoinsRepository {
  CryptoCoinsRepository({required this.dio, required this.cryptoCoinsBox});
  final Dio dio;
  final Box<CryptoCoin> cryptoCoinsBox;
  @override
  Future<List<CryptoCoin>> getCoinsList() async {
    List<CryptoCoin> coinList;
    try {
      coinList = await _fetchCoinListFromApi();
      final cryptoCoinsMap = {for (var e in coinList) e.name: e};
      cryptoCoinsBox.putAll(cryptoCoinsMap);
    } on Exception catch (e) {
      debugPrint('Exception in getCoinsList: $e');
      coinList = cryptoCoinsBox.values.toList();
    }
    coinList.sort((a, b) => b.detail.priceInUSD.compareTo(a.detail.priceInUSD));
    return coinList;
  }

  Future<List<CryptoCoin>> _fetchCoinListFromApi() async {
    final responce = await dio.get(
        'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,BABYGROK,NIZA,QUACK,RBW,STEMX,GROKGIRL,SWCH,WALV,CAKE,ETH,BNB,SOL,AID,XRP,DOT,DOGE,BSC,AVAX,CAG,DOV&tsyms=USD');
    final data = responce.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final cryptoCoinsList = dataRaw.entries.map((e) {
      final usdData =
          (e.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;
      final details = CryptoCoinDetail.fromJson(usdData);
      return CryptoCoin(name: e.key, detail: details);
    }).toList();
    return cryptoCoinsList;
  }

  @override
  Future<CryptoCoin> getCoinsDetails(String currentCoin) async {
    try {
      final coin = await _fetchCoinDetailsFromApi(currentCoin);
      cryptoCoinsBox.put(currentCoin, coin);
      return coin;
    } on Exception catch (e) {
      debugPrint('Exception in getCoinsDetails: $e');
      return cryptoCoinsBox.get(currentCoin)!;
    }
  }

  Future<CryptoCoin> _fetchCoinDetailsFromApi(String currentCoin) async {
    final responce = await dio.get(
        'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$currentCoin&tsyms=USD');
    final data = responce.data as Map<String, dynamic>;
    final dataRow = data['RAW'] as Map<String, dynamic>;
    final coinData = dataRow[currentCoin] as Map<String, dynamic>;
    final usdData = coinData['USD'] as Map<String, dynamic>;
    final details = CryptoCoinDetail.fromJson(usdData);
    return CryptoCoin(name: currentCoin, detail: details);
  }
}
