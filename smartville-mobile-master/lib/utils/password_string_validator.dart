import 'package:flutter_pw_validator/Resource/Strings.dart';

class PasswordStringValidator implements FlutterPwValidatorStrings {
  @override
  final String atLeast = 'Minimal - karakter';
  @override
  final String uppercaseLetters = '- huruf kapital';
  @override
  final String numericCharacters = '- Chiffres';
  @override
  final String specialCharacters = '- Caractères spéciaux';
}