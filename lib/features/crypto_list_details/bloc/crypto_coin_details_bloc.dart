import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/crypto_coins/crypto_coin.dart';
part 'crypto_coin_details_event.dart';
part 'crypto_coin_details_state.dart';

class CoinDetailsBloc
    extends Bloc<CryptoCoinDetailsEvent, CryptoCointDetailsState> {
  CoinDetailsBloc(this.coinRepository) : super((InitialCtyptoDetails())) {
    on<LoadCryptoCoinDetails>((event, emit) async {
      try {
        if (state is! CryptoDetailsLoaded) {
          emit(CryptoDetailsLoading());
        }
        final coinDetails =
            await coinRepository.getCoinsDetails(event.currencyCode);
        emit(CryptoDetailsLoaded(coin: coinDetails));
      } catch (e) {
        emit(CryptoDetailsLoadingFailure(exception: e));
      }
    });
  }
  final AbstractCoinsRepository coinRepository;
}
