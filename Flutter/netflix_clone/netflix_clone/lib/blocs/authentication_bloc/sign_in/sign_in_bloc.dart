import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../repository/authentication/sign_in/sign_in_repository.dart';

import '../../../utils/validators.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInRepository _signInRepository;

  SignInBloc({required SignInRepository signInRepository})
      : _signInRepository = signInRepository,
        super(SignInState.initial()) {
    on<SignInEmailChange>((event, emit) {
      emit(state.update(isEmailValid: Validators.isValidEmail(event.email)));
    });
    on<SignInPasswordChange>((event, emit) {
      emit(
        state.update(
          isPasswordValid: Validators.isValidPassword(event.password),
        ),
      );
    });
    on<SignInWithCredentialsPressed>((event, emit) async {
      emit(SignInState.loading());
      try {
        await _signInRepository.signInWithEmailAndPassword(
          event.email,
          event.password,
        );
        emit(SignInState.success());
      } on Exception catch (_) {
        emit(SignInState.failure());
      }
    });
  }
}
