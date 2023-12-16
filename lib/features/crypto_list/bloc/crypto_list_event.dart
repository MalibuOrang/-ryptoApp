part of 'crypto_list_bloc.dart';

abstract class CryptoListEvent extends Equatable {}

class LoadCtyptoList extends CryptoListEvent {
  LoadCtyptoList({this.completer});
  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}
