import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/login_usecase.dart';

// Events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginWithBiometric extends AuthEvent {}

class LoginWithPin extends AuthEvent {
  final String pin;

  const LoginWithPin(this.pin);

  @override
  List<Object?> get props => [pin];
}

class Logout extends AuthEvent {}

class CheckAuthStatus extends AuthEvent {}

// States
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final User user;

  const Authenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class Unauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

// Bloc
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;

  AuthBloc({required this.loginUseCase}) : super(AuthInitial()) {
    on<LoginWithBiometric>(_onLoginWithBiometric);
    on<LoginWithPin>(_onLoginWithPin);
    on<Logout>(_onLogout);
    on<CheckAuthStatus>(_onCheckAuthStatus);
  }

  Future<void> _onLoginWithBiometric(
    LoginWithBiometric event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final user = await loginUseCase();
    if (user != null) {
      emit(Authenticated(user));
    } else {
      emit(const AuthError('Biometric authentication failed'));
    }
  }

  Future<void> _onLoginWithPin(
    LoginWithPin event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final user = await loginUseCase(pin: event.pin);
    if (user != null) {
      emit(Authenticated(user));
    } else {
      emit(const AuthError('Invalid PIN'));
    }
  }

  Future<void> _onLogout(
    Logout event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    // TODO: implement logout use case
    emit(Unauthenticated());
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    // TODO: check if user is already logged in
    emit(Unauthenticated());
  }
}