import 'package:crypto_currency_list/generated/l10n.dart';
import 'package:flutter/material.dart';
import '../../theme/theme.dart';

Widget exceptionLoadingData(BuildContext context,
    {required Function tryAgain}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          S.of(context).somethingWentWrong,
          style: darkTheme.textTheme.headlineMedium,
        ),
        Text(S.of(context).pleaseTryAgain,
            style: darkTheme.textTheme.labelSmall?.copyWith(fontSize: 16)),
        const SizedBox(height: 30),
        TextButton(onPressed: tryAgain(), child: Text(S.of(context).tryAgain))
      ],
    ),
  );
}
