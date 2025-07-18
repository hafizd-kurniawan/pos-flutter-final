import 'dart:convert';

import 'package:flutter_pos_responsive_app/data/models/response/auth_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/response/print_model.dart';

class AuthLocalDatasource {
  //save auth data
  Future<void> saveAuthData(AuthResponseModel authResponse) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_data', authResponse.toJson());
  }

  Future<AuthResponseModel?> getAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    final authData = prefs.getString('auth_data');
    if (authData != null) {
      return AuthResponseModel.fromJson(authData);
    }
    return null;
  }

  //isAuth
  Future<bool> isAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('auth_data');
  }

  Future<void> clearAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_data');
  }

  // save size receipt
  Future<void> saveSizeReceipt(String sizeReceipt) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('size_receipt', sizeReceipt);
  }

  // get size receipt
  Future<String> getSizeReceipt() async {
    final prefs = await SharedPreferences.getInstance();
    final sizeReceipt = prefs.getString('size_receipt');
    return sizeReceipt ?? '';
  }

  Future<void> savePrinters(List<PrinterModel> printers) async {
    final prefs = await SharedPreferences.getInstance();
    final list = printers.map((p) => jsonEncode(p.toJson())).toList();
    await prefs.setStringList('saved_printers', list);
  }

  Future<List<PrinterModel>> getPrinters() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList('saved_printers') ?? [];
    return list.map((e) => PrinterModel.fromJson(jsonDecode(e))).toList();
  }

  Future<void> setDefaultPrinter(PrinterModel printer) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('default_printer', jsonEncode(printer.toJson()));
  }

  Future<PrinterModel?> getDefaultPrinter() async {
    final prefs = await SharedPreferences.getInstance();
    final string = prefs.getString('default_printer');
    if (string != null) return PrinterModel.fromJson(jsonDecode(string));
    return null;
  }

  Future<void> clearDefaultPrinter() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('default_printer');
  }
}
