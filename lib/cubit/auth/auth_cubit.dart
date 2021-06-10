import 'package:bloc/bloc.dart';
import 'package:education_assistant/services/auth_service.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final _authService = AuthService();

  AuthCubit() : super(AuthState());

  Future<void> checkCurrentUser() async {
    try {
      emit(state.copyWith(isLoading: true));
      final currentUser = await _authService.checkCurrentUser();
      print(currentUser);
      emit(state.copyWith(currentUser: currentUser, isLoading: false));
    } catch (e, s) {
      emit(state.copyWith(
        isLoading: false,
      ));
    }
  }


  Future<void> googleSignIn() async {
    try {
      emit(state.copyWith(isLoading: true));
      final response = await _authService.googleSignIn();
      emit(state.copyWith(isLoading: false, currentUser: response));
    } catch (e, s) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> googleLogOut() async {
    try {
      emit(state.copyWith(isLoading: true));
      await _authService.logOut();
      emit(state.copyWith(isLoading: false));
    } catch (e, s) {
      emit(state.copyWith(isLoading: false));
    }
  }
}