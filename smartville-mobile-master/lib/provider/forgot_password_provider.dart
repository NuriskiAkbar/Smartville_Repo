import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartville/common/constant.dart';
import 'package:smartville/model/forgot_password_response.dart';
import 'package:smartville/model/otp_response.dart';
import 'package:smartville/network/remote_data_source.dart';

class ForgotPasswordProvider with ChangeNotifier {
  Future<OtpResponse> sendOtp({required String email}) async {
    OtpResponse otp = await RemoteDataSource.sendOtp(email: email);
    notifyListeners();
    return otp;
  }

  Future<void> saveOtp(String otp) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    await _preferences.setString(keyOTP, otp);
  }

  Future<String> getOtp() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String? otp = _preferences.getString(keyOTP) ?? "";
    return otp;
  }

  Future<ForgotPasswordResponse> changePassword({
    required String email,
    required String password,
  }) async {
    ForgotPasswordResponse forgotPasswordResponse =
        await RemoteDataSource.forgotPassword(
      email: email,
      newPassword: password,
    );

    return forgotPasswordResponse;
  }

  Future<ForgotPasswordResponse> changeNewPassword({
    required String oldPassword,
    required String newPassword,
    required String token,
  }) async {
    ForgotPasswordResponse forgotPasswordResponse =
        await RemoteDataSource.newPassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
      token: token,
    );

    return forgotPasswordResponse;
  }
}
