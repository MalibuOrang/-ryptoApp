import 'package:crypto_currency_list/features/crypto_list_details/bloc/crypto_coin_details_bloc.dart';
import 'package:crypto_currency_list/features/crypto_list_details/widgets/data_row_coin.dart';
import 'package:crypto_currency_list/generated/l10n.dart';
import 'package:crypto_currency_list/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../widgets/widgets.dart';
import '../widgets/widgets.dart';

class CoinDetailsSceen extends StatefulWidget {
  const CoinDetailsSceen({super.key});

  @override
  State<CoinDetailsSceen> createState() => _CoinDetailsSceenState();
}

class _CoinDetailsSceenState extends State<CoinDetailsSceen> {
  String coin = '';
  final _coinDetailsBloc = CoinDetailsBloc(
    GetIt.I<AbstractCoinsRepository>(),
  );
  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    coin = args as String;
    _coinDetailsBloc.add(LoadCryptoCoinDetails(currencyCode: coin));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final String name = coin;
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<CoinDetailsBloc, CryptoCointDetailsState>(
        bloc: _coinDetailsBloc,
        builder: (context, state) {
          if (state is CryptoDetailsLoaded) {
            final coin = state.coin;
            final coinDetails = coin.detail;
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 160,
                    height: 160,
                    child: Image.network(coinDetails.fullImageUrl),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    coin.name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  BaseCard(
                    child: Center(
                      child: Text(
                        '${coinDetails.priceInUSD.toStringAsFixed(3)}\$',
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  BaseCard(
                    child: Column(
                      children: [
                        DataRowCoin(
                            title: S.of(context).hight24Hour,
                            value:
                                '${coinDetails.hight24Hour.toStringAsFixed(3)}\$'),
                        const SizedBox(
                          height: 8,
                        ),
                        DataRowCoin(
                            title: S.of(context).low24Hour,
                            value:
                                '${coinDetails.low24Hour.toStringAsFixed(3)}\$'),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is CryptoDetailsLoadingFailure) {
            exceptionLoadingData(context, tryAgain: () {
              _coinDetailsBloc.add(LoadCryptoCoinDetails(currencyCode: name));
            });
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
