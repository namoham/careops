import '../entities/user.dart';

abstract class AuthRepository {
  Future<User?> loginWithBiometric();
  Future<User?> loginWithPin(String pin);
  Future<void> logout();
  Future<bool> isAuthenticated();
}