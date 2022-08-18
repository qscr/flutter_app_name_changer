import 'dart:io';

import 'package:flutter_app_name_changer/src/paths.dart';
import 'package:flutter_app_name_changer/src/utils.dart';
import 'package:plist_parser/plist_parser.dart';

/// Переименовать приложение
void renameApp(String newAppName) {
  final plist = File(infoPlistPath);
  final plistString = plist.readAsStringSync();
  final plistDoc = PlistParser().parse(plistString);

  final displayName = plistDoc.containsKey('CFBundleDisplayName')
      ? plistDoc['CFBundleDisplayName'] as String
      : null;

  final bundleName =
      plistDoc.containsKey('CFBundleName') ? plistDoc['CFBundleName'] as String : null;

  final currentName = displayName ?? bundleName;

  final findString = '<string>$currentName</string>';
  final replaceString = '<string>$newAppName</string>';

  replaceData(
    filepath: infoPlistPath,
    findString: findString,
    replaceString: replaceString,
  );
}
