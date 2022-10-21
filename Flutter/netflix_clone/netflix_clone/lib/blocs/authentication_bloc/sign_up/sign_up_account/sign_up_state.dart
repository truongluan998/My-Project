part of 'sign_up_bloc.dart';

class SignUpState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isEmailValid && isPasswordValid;

  SignUpState({
    required this.isEmailValid,
    required this.isPasswordValid,
    required this.isSubmitting,
    required this.isLoading,
    required this.isSuccess,
    required this.isFailure,
  });

  factory SignUpState.initial() => SignUpState(
    isEmailValid: true,
    isPasswordValid: true,
    isSubmitting: false,
    isLoading: true,
    isSuccess: false,
    isFailure: false,
  );

  factory SignUpState.loading() => SignUpState(
    isEmailValid: true,
    isPasswordValid: true,
    isSubmitting: true,
    isLoading: true,
    isSuccess: false,
    isFailure: false,
  );

  factory SignUpState.failure() => SignUpState(
    isEmailValid: true,
    isPasswordValid: true,
    isSubmitting: false,
    isLoading: false,
    isSuccess: false,
    isFailure: true,
  );

  factory SignUpState.success() => SignUpState(
    isEmailValid: true,
    isPasswordValid: true,
    isSubmitting: false,
    isLoading: false,
    isSuccess: true,
    isFailure: false,
  );

  SignUpState update({
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

  SignUpState copyWith({
    required bool? isEmailValid,
    required bool? isPasswordValid,
    bool? isLoading,
    bool? isSubmitting,
    bool? isFailure,
    bool? isSuccess,
  }) =>
      SignUpState(
        isEmailValid: isEmailValid ?? this.isEmailValid,
        isPasswordValid: isPasswordValid ?? this.isPasswordValid,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isLoading: isLoading ?? this.isLoading ,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure,
      );
}
