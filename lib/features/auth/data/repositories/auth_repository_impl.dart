import 'package:local_auth/local_auth.dart';
import '../models/user_model.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/local_auth_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final LocalAuthDataSource localDataSource;
  final LocalAuthentication localAuth;

  AuthRepositoryImpl({
    required this.localDataSource,
    required this.localAuth,
  });

  @override
  Future<User?> loginWithBiometric() async {
    // Web doesn't support biometric, so auto-login for demo
    const user = User(
      id: '1',
      name: 'Supervisor',
      email: 'supervisor@careops.com',
      role: 'supervisor',
    );
    await localDataSource.cacheUser(UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      role: user.role,
    ));
    return user;
  }

  @override
  Future<User?> loginWithPin(String pin) async {
    // Demo: accept '1234' as default PIN
    if (pin == '1234') {
      const user = User(
        id: '1',
        name: 'Supervisor',
        email: 'supervisor@careops.com',
        role: 'supervisor',
      );
      await localDataSource.cacheUser(UserModel(
        id: user.id,
        name: user.name,
        email: user.email,
        role: user.role,
      ));
      return user;
    }
    return null;
  }

  @override
  Future<void> logout() async {
    await localDataSource.clearCache();
  }

  @override
  Future<bool> isAuthenticated() async {
    final user = await localDataSource.getCachedUser();
    return user != null;
  }
}