library flutter_app_name_changer;

import 'package:flutter_app_name_changer/src/android.dart' as android;
import 'package:flutter_app_name_changer/src/ios.dart' as ios;
import 'package:flutter_app_name_changer/src/rename_settings.dart';

void run() {
  final settings = RenameSettings.init();

  if (settings.appName != null) {
    android.renameApp(settings.appName!);
    ios.renameApp(settings.appName!);
  }

  if (settings.androidPackageName != null) {
    android.renamePackageName(settings.androidPackageName!);
  }
}
