import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../model/authentication/authentication_details.dart';
import '../../../repository/authentication/authentication_repository.dart';
import '../../../utility/exception.dart';
import '../../../utility/validators.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository;
  final Validators validators;

  StreamSubscription<AuthenticationDetail>? authStreamSub;

  @override
  Future<void> close() {
    authStreamSub?.cancel();
    return super.close();
  }

  AuthenticationBloc(this.authenticationRepository, this.validators)
      : super(AuthenticationInitialState()) {
    on<AuthenticationStartedEvent>((event, emit) async {
      try {
        emit(AuthenticationLoadingState());
        authStreamSub =
            await authenticationRepository.getAuthDetailStream().listen(
          (authDetail) {
            authDetail.isValid!
                ? emit(
                    AuthenticationSuccessState(
                      authenticationDetail: authDetail,
                    ),
                  )
                : emit(
                    AuthenticationFailureState(
                      message: 'No User',
                      exception: ListExceptionAuthentication.noUser,
                    ),
                  );
          },
        ).asFuture();
      } on Exception catch (error) {
        print(
          'Error occurred while fetching authentication detail :'
          ' ${error.toString()}',
        );
      }
    });

    on<SignInWithCredentialsPressedEvent>((event, emit) async {
      if (validators.isValidEmail(event.email) == false | event.email.isEmpty) {
        emit(
          AuthenticationFailureState(
            message: 'Email Invalid',
            exception: ListExceptionAuthentication.emailInvalid,
          ),
        );
      } else if (validators.isValidPassword(event.password) ==
          false | event.password.isEmpty) {
        emit(
          AuthenticationFailureState(
            message: 'Invalid Password',
            exception: ListExceptionAuthentication.passwordInvalid,
          ),
        );
      } else {
        emit(AuthenticationLoadingState());
        try {
          await authenticationRepository.signInWithEmailAndPassword(
            event.email,
            event.password,
          );
          emit(AuthenticationSuccessState());
        } on Exception catch (_) {
          emit(
            AuthenticationFailureState(
              message: 'Something wrong! Try again',
              exception: ListExceptionAuthentication.failAuthentication,
            ),
          );
        }
      }
    });

    on<SignUpWithCredentialsPressedEvent>((event, emit) async {
      if (validators.isValidFullName(event.fullName) ==
          false || event.fullName.isEmpty) {
        emit(
          AuthenticationFailureState(
            message: 'Invalid Full Name',
            exception: ListExceptionAuthentication.fullNameInvalid,
          ),
        );
      } else if (validators.isValidEmail(event.email) ==
          false || event.email == '') {
        emit(
          AuthenticationFailureState(
            message: 'Email Invalid',
            exception: ListExceptionAuthentication.emailInvalid,
          ),
        );
      } else if (validators.isValidPassword(event.password) ==
          false || event.password == '') {
        emit(
          AuthenticationFailureState(
            message: 'Invalid Password',
            exception: ListExceptionAuthentication.passwordInvalid,
          ),
        );
      } else {
        emit(AuthenticationLoadingState());
        try {
          final signUpUser =
              await authenticationRepository.signUpWithEmailAndPassword(
            event.fullName,
            event.email,
            event.password,
          );
          if (signUpUser == true) {
            emit(AuthenticationSuccessState());
          } else {
            emit(
              AuthenticationFailureState(
                message: 'Something wrong! Try again',
                exception: ListExceptionAuthentication.failAuthentication,
              ),
            );
          }
        } on Exception catch (e) {
          print(e);
          emit(
            AuthenticationFailureState(
              message: 'Something wrong! Try again',
              exception: ListExceptionAuthentication.failAuthentication,
            ),
          );
        }
      }
    });
  }
}
