import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'check_internet_connection_event.dart';
import 'check_internet_connection_state.dart';

class CheckInternetConnectionBloc
    extends Bloc<CheckInternetConnectionEvent, CheckInternetConnectionState> {
  CheckInternetConnectionBloc() : super(CheckInternetConnectionInitial()) {
    on<CheckInternetFirstTimeEvent>((event, emit) async {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        emit(
          CheckInternetConnectionInitial(
            message: 'No Connection, pls connect.',
          ),
        );
      }
    });
    on<LostInternetEvent>((event, emit) async {
      emit(LostInternetState(message: 'Lost Internet!!!'));
    });
    on<ReconnectInternetEvent>((event, emit) async {
      emit(ReconnectTheInternetState(message: 'Reconnected.'));
    });
  }
}
