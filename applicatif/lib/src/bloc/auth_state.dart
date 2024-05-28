import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingAppState extends AuthState {}
class LoginInitState extends AuthState {}

class LoginLoadingState extends AuthState {}

class UserLoginSuccessState extends AuthState {}

class AdminLoginSuccessState extends AuthState {}

class LoginErrorState extends AuthState {
  final String message;
  LoginErrorState({required this.message});
}
class LogoutLoaddingState extends AuthState {}