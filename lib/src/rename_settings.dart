import 'package:flutter_app_name_changer/src/utils.dart';

/// Настройки пакета
class RenameSettings {
  /// Имя приложения
  final String? appName;

  /// Название Android-пакета
  final String? androidPackageName;

  /// Название iOS-бандла
  final String? iosBundleName;

  RenameSettings({
    this.appName,
    this.androidPackageName,
    this.iosBundleName,
  });

  static RenameSettings init() {
    const appNameKey = 'flutter_app_name_changer/app_name';
    const androidPackageKey = 'flutter_app_name_changer/android_package_name';
    const iosBundleKey = 'flutter_app_name_changer/ios_bundle_name';
    final settingsMap = getYamlData(filepath: 'pubspec.yaml', keys: [
      appNameKey,
      androidPackageKey,
      iosBundleKey,
    ]);
    return RenameSettings(
      appName: settingsMap[appNameKey],
      androidPackageName: settingsMap[androidPackageKey],
      iosBundleName: settingsMap[iosBundleKey],
    );
  }
}
