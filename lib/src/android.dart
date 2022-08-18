import 'dart:io';

import 'package:flutter_app_name_changer/src/paths.dart';
import 'package:flutter_app_name_changer/src/utils.dart';

/// Переименовать приложение
void renameApp(String newAppName) {
  const attributePath = 'manifest/application/android:label';
  final dataMap = getXmlData(
    filepath: mainManifestPath,
    keys: [
      attributePath,
    ],
  );

  final findString = 'android:label="${dataMap[attributePath]}"';
  final replaceString = 'android:label="$newAppName"';

  replaceData(
    filepath: mainManifestPath,
    findString: findString,
    replaceString: replaceString,
  );
}

void renamePackageName(String newPackageName) {
  const attributePath = 'manifest/package';
  final curPackageName = getXmlData(
    filepath: mainManifestPath,
    keys: [
      attributePath,
    ],
  ).values.first;
  replaceData(
    filepath: mainManifestPath,
    findString: curPackageName,
    replaceString: newPackageName,
  );
  replaceData(
    filepath: debugManifestPath,
    findString: curPackageName,
    replaceString: newPackageName,
  );
  replaceData(
    filepath: profileManifestPath,
    findString: curPackageName,
    replaceString: newPackageName,
  );
  replaceData(
    filepath: buildGradlePath,
    findString: curPackageName,
    replaceString: newPackageName,
  );
  final curPackageNameSplit = curPackageName.split('.');
  final newPackageNameSplit = newPackageName.split('.');
  const packagePath = 'android/app/src/main/kotlin';
  final domainDir = Directory('$packagePath/${curPackageNameSplit[0]}')
      .renameSync('$packagePath/${newPackageNameSplit[0]}');
  final middleDir = Directory('${domainDir.path}/${curPackageNameSplit[1]}')
      .renameSync('${domainDir.path}/${newPackageNameSplit[1]}');
  Directory('${middleDir.path}/${curPackageNameSplit[2]}')
      .renameSync('${middleDir.path}/${newPackageNameSplit[2]}');
  replaceData(
    filepath: mainActivityPath.replaceAll('{packageName}', newPackageName.replaceAll('.', '/')),
    findString: curPackageName,
    replaceString: newPackageName,
  );
}
