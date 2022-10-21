import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../../repository/authentication/sign_up/sign_up_repository.dart';

part 'check_email_exits_event.dart';

part 'check_email_exits_state.dart';

class CheckEmailExitsBloc
    extends Bloc<CheckEmailExitsEvent, CheckEmailExitsState> {
  final SignUpRepository _signUpRepository;

  CheckEmailExitsBloc({required SignUpRepository signUpRepository})
      : _signUpRepository = signUpRepository,
        super(CheckEmailExitsInitial()) {
    on<PressToCheckEmail>((event, emit) async {
      emit(CheckEmailExitsLoading());
      try {
        final email = await _signUpRepository.checkEmailExits(event.email);
        if(email != null) {
          if(email == true) {
            emit(EmailAlreadyExists(email: event.email));
          }
          if(email == false) {
            emit(EmailDoesNotExists(email: event.email));
          }
        }
      } on Exception catch (_) {
        emit(CheckEmailFail(message: 'Fail! Try again.'));
      }
    });
  }
}
