part of 'crypto_coin_details_bloc.dart';

abstract class CryptoCointDetailsState extends Equatable {}

class InitialCtyptoDetails extends CryptoCointDetailsState {
  @override
  List<Object?> get props => [];
}

class CryptoDetailsLoading extends CryptoCointDetailsState {
  @override
  List<Object?> get props => [];
}

class CryptoDetailsLoaded extends CryptoCointDetailsState {
  CryptoDetailsLoaded({required this.coin});
  final CryptoCoin coin;

  @override
  List<Object?> get props => [coin];
}

class CryptoDetailsLoadingFailure extends CryptoCointDetailsState {
  CryptoDetailsLoadingFailure({required this.exception});
  final Object? exception;

  @override
  List<Object?> get props => [exception];
}
