import 'dart:io';

import 'package:xml/xml.dart';
import 'package:yaml/yaml.dart';

/// Получить данные из YAML-файла
/// синтаксис передачи ключа: "dir/subdir/subsubdir"
Map getYamlData({
  required String filepath,
  required List<String> keys,
}) {
  final File yamlFile = File(filepath);
  final Map yamlData = loadYaml(yamlFile.readAsStringSync());
  final Map yamlKeyData = {};

  for (var key in keys) {
    final keyPath = key.split('/');
    Map<dynamic, dynamic>? tempMap = yamlData;
    for (var i = 0; i < keyPath.length - 1; i++) {
      if (!(tempMap?.containsKey(keyPath[i]) ?? true)) {
        tempMap = null;
        break;
      }
      tempMap = tempMap?[keyPath[i]];
    }
    yamlKeyData.putIfAbsent(key, () => tempMap?[keyPath.last]);
  }

  return yamlKeyData;
}

/// Получить данные из XML-файла
/// синтаксис передачи ключа: "tag/subtag/attribute"
Map<String, String> getXmlData({
  required String filepath,
  required List<String> keys,
}) {
  final File xmlFile = File(filepath);
  final xmlString = xmlFile.readAsStringSync();
  final xmlData = XmlDocument.parse(xmlString);
  final Map<String, String> dataMap = {};
  for (var key in keys) {
    final keyPath = key.split('/');
    XmlElement? curElement;
    for (var i = 0; i < keyPath.length; i++) {
      if (i == 0) {
        curElement = xmlData.getElement(keyPath[0]);
      }
      if (i == keyPath.length - 1) {
        dataMap.putIfAbsent(key, () => curElement?.getAttribute(keyPath[keyPath.length - 1]) ?? '');
      }
      if (i > 0 && i < keyPath.length - 1) {
        curElement = curElement?.getElement(keyPath[i]);
      }
    }
  }
  return dataMap;
}

/// Перезаписать файл с замененным контентом
void replaceData({
  required String filepath,
  required String findString,
  required String replaceString,
}) {
  final file = File(filepath);
  final fileString = file.readAsStringSync();
  file.writeAsStringSync(fileString.replaceAll(findString, replaceString));
}
