import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DataService {
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  /// guarda una variable en secureStorage
  Future<bool> addItem(String nombre, String valor) async {
    try {
      if (await secureStorage.read(key: nombre) != null) {
        await secureStorage.delete(key: nombre);
      }
      // if (await secureStorage.read(key: nombre) == null) {
      await secureStorage.write(key: nombre, value: valor);
      return true;
      // } else {
      //   return false;
      // }
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<String?> getItem(String nombre) async {
    try {
      return await secureStorage.read(key: nombre);
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<bool> deleteItem(String nombre) async {
    try {
      await secureStorage.delete(key: nombre);
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
