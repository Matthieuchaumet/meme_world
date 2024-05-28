import 'package:applicatif/src/repository/auth_repo.dart';

import 'auth_events.dart';
import 'auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvents, AuthState> {
  AuthRepository repo;
  AuthBloc(  this.repo) : super(LoadingAppState()) {
    on<StartEvent>((event, emit) => _mapStartEventToState(emit));
    on<LoginButtonPressed>((event, emit) => _mapLoginButtonPressedToState(event, emit));
    on<LogoutButtonPressed>((event , emit) => _mapLogoutButtonPressedToState(event, emit));
  }

  void _mapStartEventToState(Emitter<AuthState> emit) async {
    var log = await repo.checkLoggedIn();
    emit(LoadingAppState());
    if (log == 'User') {
      emit(UserLoginSuccessState());
  } else if (log == 'Admin') {
      emit(AdminLoginSuccessState());
  } else {
      emit(LoginInitState());
  }
}

  void _mapLoginButtonPressedToState(LoginButtonPressed event, Emitter<AuthState> emit) async {
    var pref = await SharedPreferences.getInstance();
    emit(LoginLoadingState());
    var data = await repo.login(event.username, event.password);
    Future.delayed(const Duration(seconds: 1));
    if (data == "auth problem") {
      emit(LoginErrorState(message: "auth problem"));
      return;
    }
    if (data['role'] == "User") {
      pref.setInt("id", data['id'] + 1);
      pref.setString("token", data['token']);
      pref.setString("role", data['role']);
      pref.setString("username", data['userName']);
      emit(UserLoginSuccessState());
    } else if (data['role'] == 'Admin') {
      pref.setInt("id", data['id'] + 1);
      pref.setString("token", data['token']);
      pref.setString("role", data['role']);
      pref.setString("username", data['userName']);
      emit(AdminLoginSuccessState());
    } 
  }
  
  void  _mapLogoutButtonPressedToState(LogoutButtonPressed event, Emitter<AuthState> emit) async {
     emit(LogoutLoaddingState());
     await Future.delayed(const Duration(seconds: 1));
    var pref = await SharedPreferences.getInstance();
    await pref.clear();
    emit(LoginInitState());
  }
}
