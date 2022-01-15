import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/constant.dart';
import '../model/user_response.dart';
import '../model/register_response.dart';
import '../network/remote_data_source.dart';

class UserProvider with ChangeNotifier {
  String? _token;
  String? _imageProfile;
  String? _userName;
  String? _userEmail;
  String? _userTelp;
  String? _userNik;
  String? _userAlamat;
  bool? _userJenisKelamin;
  String? _tokenFCM;


  late final SharedPreferences _preferences;

  String? get token => _token;
  String? get imageProfile => _imageProfile;
  String? get userName => _userName;
  String? get userEmail => _userEmail;
  String? get userTelp => _userTelp;
  String? get userNik => _userNik;
  String? get userAlamat => _userAlamat;
  bool? get userJenisKelamin => _userJenisKelamin;
  String? get tokenFCM => _tokenFCM;


  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    _token = _preferences.getString(keyToken);
    _imageProfile = _preferences.getString(keyImageProfile);
    _userName = _preferences.getString(keyUserName);
    _userEmail = _preferences.getString(keyUserEmail);
    _userTelp = _preferences.getString(keyUserTelp);
    _userNik = _preferences.getString(keyUserNik);
    _userAlamat = _preferences.getString(keyUserAlamat);
    _userJenisKelamin = _preferences.getBool(keyUserJenisKelamin);
    _tokenFCM = _preferences.getString(keyTokenFCM);

  }

  Future<User> login({
    required String email,
    required String password,
  }) async {
    User auth = await RemoteDataSource.login(
      email: email,
      password: password,
    );
    _token = auth.data?.token;
    _imageProfile = auth.data?.profilePic;
    _userName = auth.data?.nama;
    _userEmail = auth.data?.email;
    _userNik = auth.data?.nik;
    _userTelp = auth.data?.noHp;
    _userAlamat = auth.data?.alamat;
    _userJenisKelamin = auth.data?.jenisKelamin;
    _tokenFCM = await FirebaseMessaging.instance.getToken();
    if (_token != null) {
      await _preferences.setString(
        keyToken,
        _token!,
      );
      await _preferences.setString(
        keyImageProfile,
        _imageProfile!,
      );
      await _preferences.setString(
        keyUserName,
        _userName!,
      );
      await _preferences.setString(
        keyUserEmail,
        _userEmail!,
      );
      await _preferences.setString(
        keyUserTelp,
        _userTelp!,
      );
      await _preferences.setString(
        keyUserNik,
        _userNik!,
      );
      await _preferences.setString(
        keyUserAlamat,
        _userAlamat!,
      );
      await _preferences.setBool(
        keyUserJenisKelamin,
        _userJenisKelamin!,
      );
      await _preferences.setString(
        keyTokenFCM,
        _tokenFCM!,
      );
    }
    notifyListeners();
    return auth;
  }

  Future<Register> register({
    required String nik,
    required String nama,
    required String email,
    required String password,
    required String tglLahir,
    required String tempatLahir,
    required String alamat,
    required String dusun,
    required String rt,
    required String rw,
    required int jenisKelamin,
    required String noHp,
    File? profilePic,
  }) async {
    Register register = await RemoteDataSource.register(
      nik: nik,
      nama: nama,
      email: email,
      password: password,
      tglLahir: tglLahir,
      tempatLahir: tempatLahir,
      alamat: alamat,
      dusun: dusun,
      rt: rt,
      rw: rw,
      jenisKelamin: jenisKelamin,
      noHp: noHp,
      imageProfile: profilePic,
    );
    _token = register.data.token;
    _imageProfile = register.data.profilePic;
    _userName = register.data.nama;
    _userEmail = register.data.email;
    _userNik = register.data.nik;
    _userTelp = register.data.noHp;
    _userAlamat = register.data.alamat;
    _userJenisKelamin = register.data.jenisKelamin;
    if (_token != null) {
      await _preferences.setString(
        keyToken,
        _token!,
      );
      await _preferences.setString(
        keyImageProfile,
        _imageProfile!,
      );
      await _preferences.setString(
        keyUserName,
        _userName!,
      );
      await _preferences.setString(
        keyUserEmail,
        _userEmail!,
      );
      await _preferences.setString(
        keyUserNik,
        _userNik!,
      );
      await _preferences.setString(
        keyUserTelp,
        _userTelp!,
      );
      await _preferences.setString(
        keyUserAlamat,
        _userAlamat!,
      );
      await _preferences.setBool(
        keyUserJenisKelamin,
        _userJenisKelamin!,
      );
    }
    notifyListeners();
    return register;
  }

  Future<void> logout() async {
    _token = null;
    _userName = null;
    _imageProfile = null;
    _userNik = null;
    _userTelp = null;

    await _preferences.remove(keyToken);
    await _preferences.remove(keyUserName);
    await _preferences.remove(keyImageProfile);
    await _preferences.remove(keyUserNik);
    await _preferences.remove(keyUserTelp);
    await _preferences.remove(keyUserAlamat);
    await _preferences.remove(keyUserJenisKelamin);

    notifyListeners();
  }

  Future<Register> editProfile({
    required String token,
    required String nama,
    required String alamat,
    required String noHp,
    required String email,
    required bool jenisKelamin,
    File? profilePic,
  }) async {
    Register register = await RemoteDataSource.editProfile(
      token: token,
      nama: nama,
      email: email,
      alamat: alamat,
      noHp: noHp,
      imageProfile: profilePic,
      jenisKelamin: jenisKelamin,
    );
    if (profilePic != null) {
      _imageProfile = register.data.profilePic;
    }
    _userName = register.data.nama;
    _userEmail = register.data.email;
    _userAlamat = register.data.alamat;
    _userTelp = register.data.noHp;
    _userJenisKelamin = register.data.jenisKelamin;
    if (_token != null) {
      if (profilePic != null) {
        await _preferences.setString(
          keyImageProfile,
          _imageProfile!,
        );
      }
      await _preferences.setString(
        keyUserName,
        _userName!,
      );
      await _preferences.setString(
        keyUserEmail,
        _userEmail!,
      );
      await _preferences.setString(
        keyUserTelp,
        _userTelp!,
      );
      await _preferences.setString(
        keyUserAlamat,
        _userAlamat!,
      );
      await _preferences.setBool(
        keyUserJenisKelamin,
        _userJenisKelamin!,
      );
    }
    notifyListeners();
    return register;
  }
}
