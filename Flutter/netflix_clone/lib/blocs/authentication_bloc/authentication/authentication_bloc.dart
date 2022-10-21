import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../models/authentication_details.dart';
import '../../../repository/authentication/sign_in/sign_in_repository.dart';
import '../../../utils/validators.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final SignInRepository _signInRepository;

  StreamSubscription<AuthenticationDetail>? authStreamSub;

  @override
  Future<void> close() {
    authStreamSub?.cancel();
    return super.close();
  }

  AuthenticationBloc({
    required SignInRepository signInRepository,
  })  : _signInRepository = signInRepository,
        super(AuthenticationInitial()) {
    //Check account on the device
    on<AuthenticationEvent>((event, emit) async {
      if (event is AuthenticationStarted) {
        try {
          emit(AuthenticationLoading());
          await _signInRepository.getAuthDetailStream().listen(
            (authDetail) {
              authDetail.isValid!
                  ? emit(
                      AuthenticationSuccess(authenticationDetail: authDetail),
                    )
                  : emit(
                      AuthenticationFailure(
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
      }
    });

    // Device without account, login with Google account
    on<AuthenticationNewAccountSignInWithGoogle>((event, emit) async {
      emit(AuthenticationLoading());
      final authDetail = await _signInRepository.authenticateWithGoogle();
      if (authDetail != null) {
        try {
          authDetail.isValid!
              ? emit(
                  AuthenticationSuccess(
                    authenticationDetail: authDetail,
                  ),
                )
              : emit(
                  AuthenticationFailure(
                    message: 'Login with Google account Fail',
                    exception: ListExceptionAuthentication.failAuthentication,
                  ),
                );
        } on Exception catch (_) {
          emit(
            AuthenticationFailure(
              message: 'Login Fail',
              exception: ListExceptionAuthentication.failAuthentication,
            ),
          );
        }
      }
    });

    // Device without account, login with Facebook account
    on<AuthenticationNewAccountSignInWithFacebook>((event, emit) async {
      emit(AuthenticationLoading());
      final authDetail = await _signInRepository.authenticateWithFacebook();
      if (authDetail != null) {
        try {
          authDetail.isValid!
              ? emit(
                  AuthenticationSuccess(
                    authenticationDetail: authDetail,
                  ),
                )
              : emit(
                  AuthenticationFailure(
                    message: 'Login with Facebook account Fail',
                    exception: ListExceptionAuthentication.failAuthentication,
                  ),
                );
        } on Exception catch (_) {
          emit(
            AuthenticationFailure(
              message: 'Login Fail',
              exception: ListExceptionAuthentication.failAuthentication,
            ),
          );
        }
      }
    });

    //Logout
    on<AuthenticationExited>((event, emit) async {
      emit(AuthenticationLoading());
      try {
        await _signInRepository.unAuthenticate();
      } on Exception catch (error) {
        print('Error occurred while logging out. : ${error.toString()}');
        emit(
          AuthenticationFailure(
            message: 'Unable to logout. Please try again.',
            exception: ListExceptionAuthentication.logOutFail,
          ),
        );
      }
    });
  }
}
