import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:provider/provider.dart';
import 'package:smartville/common/colors.dart';
import 'package:smartville/common/constant.dart';
import 'package:smartville/common/text_styles.dart';
import 'package:smartville/model/forgot_password_response.dart';
import 'package:smartville/model/notification_message.dart';
import 'package:smartville/pages/login_page.dart';
import 'package:smartville/pages/notifikasi_berhasil_page.dart';
import 'package:smartville/provider/forgot_password_provider.dart';
import 'package:smartville/provider/user_provider.dart';
import 'package:smartville/utils/password_string_validator.dart';
import 'package:smartville/widgets/custom_form_field.dart';

class ChangeNewPasswordPage extends StatefulWidget {
  const ChangeNewPasswordPage({Key? key}) : super(key: key);
  static const routeName = "change_new_password";
  @override
  _ChangeNewPasswordState createState() => _ChangeNewPasswordState();
}

class _ChangeNewPasswordState extends State<ChangeNewPasswordPage> {
  TextEditingController oldPwController = TextEditingController();
  TextEditingController newPwController = TextEditingController();
  TextEditingController pwConfirmController = TextEditingController();
  bool validPassword = false;
  bool _onSend = false;
  final _formKey = GlobalKey<FormState>();

  Future _changeNewPassword() async {
    ForgotPasswordProvider changePasswordProvider =
        context.read<ForgotPasswordProvider>();
    UserProvider userProvider = context.read<UserProvider>();
    setState(() {
      _onSend = true;
    });
    if (newPwController.text != pwConfirmController.text || !validPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password tidak valid"),
        ),
      );
    } else if (oldPwController.text == newPwController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password lama tidak boleh sama dengan password baru"),
        ),
      );
    } else {
      ForgotPasswordResponse res =
          await changePasswordProvider.changeNewPassword(
        oldPassword: oldPwController.text,
        newPassword: newPwController.text,
        token: userProvider.token!,
      );
      if (res.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              res.message,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              res.message,
            ),
          ),
        );
        Navigator.pop(context);
      }
    }
    setState(() {
      _onSend = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Permohonan Surat Pengantar',
            style: whiteText.copyWith(fontSize: 14),
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: const BackButton(color: Color(0xFF3C4D60)),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Image(
                      image: AssetImage('assets/password.png'),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Atur Ulang\nPassword',
                    style: blackText.copyWith(
                        fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomFormField(
                          obsecureText: true,
                          textEditingController: oldPwController,
                          textHint: 'Masukan password lama',
                          suffixIcon: Icons.visibility_rounded,
                        ),
                        const SizedBox(height: 22),
                        Container(
                          margin: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                          ),
                          height: 3,
                          color: const Color(0xFFF38263),
                        ),
                        const SizedBox(height: 22),
                        CustomFormField(
                          obsecureText: true,
                          textEditingController: newPwController,
                          textHint: 'Masukan password baru',
                          suffixIcon: Icons.visibility_rounded,
                        ),
                        const SizedBox(height: 20),
                        FlutterPwValidator(
                          controller: newPwController,
                          minLength: 8,
                          uppercaseCharCount: 1,
                          width: 400,
                          height: 60,
                          strings: PasswordStringValidator(),
                          onSuccess: () {
                            setState(() {
                              validPassword = true;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomFormField(
                          obsecureText: true,
                          textEditingController: pwConfirmController,
                          textHint: 'Konfirmasi password baru',
                          suffixIcon: Icons.visibility_rounded,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  _onSend
                      ? const LinearProgressIndicator()
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: primaryColor,
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _changeNewPassword();
                              }
                            },
                            child: Text(
                              'Ubah Password',
                              style: blackText.copyWith(fontSize: 16),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
