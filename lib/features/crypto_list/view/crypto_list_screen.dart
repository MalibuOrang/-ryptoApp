import 'dart:async';
import 'package:crypto_currency_list/features/crypto_list/bloc/crypto_list_bloc.dart';
import 'package:crypto_currency_list/generated/l10n.dart';
import 'package:crypto_currency_list/repositories/crypto_coins/crypto_coin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../widgets/widgets.dart';
import '../widgets/widgets.dart';

class CryptoListScrean extends StatefulWidget {
  const CryptoListScrean({
    super.key,
  });

  @override
  State<CryptoListScrean> createState() => _CryptoListScreanState();
}

class _CryptoListScreanState extends State<CryptoListScrean> {
  final _cryptoListBloc = CryptoListBloc(GetIt.I<AbstractCoinsRepository>());
  @override
  void initState() {
    _cryptoListBloc.add(LoadCtyptoList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).appName),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final completer = Completer();
          _cryptoListBloc.add(LoadCtyptoList(completer: completer));
          return completer.future;
        },
        child: BlocBuilder<CryptoListBloc, CryptoListState>(
          bloc: _cryptoListBloc,
          builder: (context, state) {
            if (state is CryptoListLoaded) {
              return ListView.separated(
                padding: const EdgeInsets.only(top: 16),
                itemCount: state.coinsList.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, i) {
                  final coin = state.coinsList[i];
                  return CryptoCoinTile(
                    coin: coin,
                  );
                },
              );
            }
            if (state is CryptoListLoadingFailure) {
              exceptionLoadingData(context, tryAgain: () {
                _cryptoListBloc.add(LoadCtyptoList());
              });
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
