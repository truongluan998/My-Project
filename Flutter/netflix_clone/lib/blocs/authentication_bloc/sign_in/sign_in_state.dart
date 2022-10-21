part of 'sign_in_bloc.dart';

class SignInState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isEmailValid && isPasswordValid;

  SignInState({
    required this.isEmailValid,
    required this.isPasswordValid,
    required this.isSubmitting,
    required this.isLoading,
    required this.isSuccess,
    required this.isFailure,
  });

  factory SignInState.initial() => SignInState(
        isEmailValid: true,
        isPasswordValid: true,
        isSubmitting: false,
        isLoading: true,
        isSuccess: false,
        isFailure: false,
      );

  factory SignInState.loading() => SignInState(
        isEmailValid: true,
        isPasswordValid: true,
        isSubmitting: true,
        isLoading: true,
        isSuccess: false,
        isFailure: false,
      );

  factory SignInState.failure() => SignInState(
        isEmailValid: true,
        isPasswordValid: true,
        isSubmitting: false,
        isLoading: false,
        isSuccess: false,
        isFailure: true,
      );

  factory SignInState.success() => SignInState(
        isEmailValid: true,
        isPasswordValid: true,
        isSubmitting: false,
        isLoading: false,
        isSuccess: true,
        isFailure: false,
      );

  SignInState update({
    bool? isEmailValid,
    bool? isPasswordValid,
  }) =>
      copyWith(
        isEmailValid: isEmailValid,
        isPasswordValid: isPasswordValid,
        isSubmitting: false,
        isLoading: false,
        isSuccess: false,
        isFailure: false,
      );

  SignInState copyWith({
    required bool? isEmailValid,
    required bool? isPasswordValid,
    bool? isLoading,
    bool? isSubmitting,
    bool? isFailure,
    bool? isSuccess,
  }) =>
      SignInState(
        isEmailValid: isEmailValid ?? this.isEmailValid,
        isPasswordValid: isPasswordValid ?? this.isPasswordValid,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isLoading: isLoading ?? this.isLoading ,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure,
      );
}
