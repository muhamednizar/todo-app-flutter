import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/config/theme/app_theme.dart';
import 'package:todo_app/core/routes_manager.dart';
import 'package:todo_app/presentation/providers/settings_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingsProvider>(
      create: (_) => SettingsProvider(),
      child: Consumer<SettingsProvider>(
        builder: (context, myProvider, _) {
          // استدعاء الدالة loadSettings لتحديث الإعدادات عند بداية التطبيق
          myProvider.loadSettings();

          return ScreenUtilInit(
            designSize: const Size(412, 870),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                locale: myProvider.currentLocale,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: [
                  Locale('en'), // الإنجليزية
                  Locale('ar'), // العربية
                ],
                debugShowCheckedModeBanner: false,
                onGenerateRoute: RoutesManager.router,
                initialRoute: RoutesManager.loginRoute,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: myProvider.currentTheme,
              );
            },
          );
        },
      ),
    );
  }
}
