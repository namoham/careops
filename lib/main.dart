import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'features/auth/data/datasources/local_auth_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Dependency injection (manual for now)
    final localDataSource = LocalAuthDataSource();
    final localAuth = LocalAuthentication();
    final repository = AuthRepositoryImpl(
      localDataSource: localDataSource,
      localAuth: localAuth,
    );
    final loginUseCase = LoginUseCase(repository);

    return MaterialApp(
      title: 'CareOps',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => AuthBloc(loginUseCase: loginUseCase),
        child: const LoginPage(),
      ),
    );
  }
}