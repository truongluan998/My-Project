import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../../repository/authentication/sign_up/sign_up_repository.dart';
import '../../../../utils/validators.dart';


part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpRepository _signUpRepository;

  SignUpBloc({required SignUpRepository signUpRepository})
      : _signUpRepository = signUpRepository,
        super(SignUpState.initial()) {
    on<SignUpEmailChange>((event, emit) {
      emit(state.update(isEmailValid: Validators.isValidEmail(event.email)));
    });
    on<SignUpPasswordChange>((event, emit) {
      emit(
        state.update(
          isPasswordValid: Validators.isValidPassword(event.password),
        ),
      );
    });
    on<SignUpWithCredentialsPressed>((event, emit) async {
      emit(SignUpState.loading());
      try {
        await _signUpRepository.signUpWithEmailAndPassword(
          event.email,
          event.password,
        );
        emit(SignUpState.success());
      } on Exception catch (_) {
        emit(SignUpState.failure());
      }
    });
  }
}
