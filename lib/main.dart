import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:trainings/app.dart';
import 'package:trainings/generated/codegen_loader.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      assetLoader: const CodegenLoader(),
      child: const App(),
    ),
  );
}
