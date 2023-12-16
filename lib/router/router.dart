import '../features/crypto_list/view/view.dart';
import '../features/crypto_list_details/view/view.dart';

final routes = {
  '/': (context) => const CryptoListScrean(),
  '/coin': (context) => const CoinDetailsSceen(),
};
