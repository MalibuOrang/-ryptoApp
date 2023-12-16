import 'package:crypto_currency_list/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:crypto_currency_list/router/router.dart';
import 'package:crypto_currency_list/theme/theme.dart';
import 'package:flutter/material.dart';

class CryptoCurrenciesRateApp extends StatelessWidget {
  const CryptoCurrenciesRateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Crypto Info',
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: darkTheme,
        routes: routes);
  }
}
