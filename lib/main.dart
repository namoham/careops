import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'database/app_database.dart';
import 'features/auth/data/datasources/local_auth_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/staff/data/repositories/staff_repository_impl.dart';
import 'features/staff/presentation/bloc/staff_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localDataSource = LocalAuthDataSource();
    final localAuth = LocalAuthentication();
    final authRepository = AuthRepositoryImpl(
      localDataSource: localDataSource,
      localAuth: localAuth,
    );
    final loginUseCase = LoginUseCase(authRepository);

    final appDatabase = AppDatabase();
    final staffRepository = StaffRepositoryImpl();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(loginUseCase: loginUseCase),
        ),
        BlocProvider(
          create: (context) => StaffBloc(repository: staffRepository),
        ),
      ],
      child: MaterialApp(
        title: 'CareOps',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
        ),
        home: const LoginPage(),
      ),
    );
  }
}