import 'package:flutter/material.dart';
import 'package:leksika/core/router/app_router.dart';
import 'package:leksika/shared/theme/app_theme.dart';

class LeksikaApp extends StatelessWidget {
  const LeksikaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Leksika',
      theme: AppTheme.light,
      initialRoute: AppRouter.initialRoute,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
