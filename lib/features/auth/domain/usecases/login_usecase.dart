import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  const LoginUseCase(this.repository);

  Future<User?> call({String? pin}) async {
    if (pin != null && pin.isNotEmpty) {
      return await repository.loginWithPin(pin);
    }
    return await repository.loginWithBiometric();
  }
}