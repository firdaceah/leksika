import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Tambahkan import bloc
import 'package:leksika/core/di/injection_container.dart'; // Import service locator (sl)
import 'package:leksika/core/router/app_router.dart';
import 'package:leksika/features/auth/presentation/bloc/auth_bloc.dart'; // Import AuthBloc
import 'package:leksika/features/auth/presentation/bloc/auth_event.dart'; // Import AuthEvent
import 'package:leksika/shared/theme/app_theme.dart';

class LeksikaApp extends StatelessWidget {
  const LeksikaApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Membungkus MaterialApp dengan BlocProvider global
    return BlocProvider(
      // Fetch user dilakukan satu kali saat aplikasi pertama kali dijalankan
      create: (context) => sl<AuthBloc>()..add(const FetchUserRequested()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Leksika',
        theme: AppTheme.light,
        initialRoute: AppRouter.initialRoute,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}