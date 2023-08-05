import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isDeviceConnected;
}

class NetworkInfoImp implements NetworkInfo {
  final InternetConnectionChecker networkConnectionChecker;
  NetworkInfoImp({required this.networkConnectionChecker});

  @override
  Future<bool> get isDeviceConnected => networkConnectionChecker.hasConnection;
}
