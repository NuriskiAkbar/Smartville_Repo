import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:provider/provider.dart';
import 'package:smartville/common/colors.dart';
import 'package:smartville/common/constant.dart';
import 'package:smartville/common/text_styles.dart';
import 'package:smartville/model/forgot_password_response.dart';
import 'package:smartville/pages/login_page.dart';
import 'package:smartville/provider/forgot_password_provider.dart';
import 'package:smartville/utils/password_string_validator.dart';
import 'package:smartville/widgets/custom_form_field.dart';

class ChangePasswordForgotPage extends StatefulWidget {
  static const routeName = "change-password-forgot";

  final String email;
  const ChangePasswordForgotPage({Key? key, required this.email})
      : super(key: key);

  @override
  _ChangePasswordForgotPageState createState() =>
      _ChangePasswordForgotPageState();
}

class _ChangePasswordForgotPageState extends State<ChangePasswordForgotPage> {
  TextEditingController pwController = TextEditingController();
  TextEditingController pwConfirmController = TextEditingController();
  bool validPassword = false;
  bool _onSend = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ForgotPasswordProvider forgotPasswordProvider =
        Provider.of<ForgotPasswordProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Image(
                      image: AssetImage('assets/automation.png'),
                    ),
                  ),
                  const Text(
                    'Atur Ulang Password',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Masukkan Password Baru',
                          style: greyText,
                        ),
                        const SizedBox(height: 4),
                        CustomFormField(
                            obsecureText: true,
                            textEditingController: pwController,
                            textHint: 'Masukan password baru Anda',
                            suffixIcon: Icons.visibility_rounded),
                        const SizedBox(height: 10),
                        FlutterPwValidator(
                          controller: pwController,
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
                        Text(
                          'Konfirmasi Password',
                          style: greyText,
                        ),
                        const SizedBox(height: 4),
                        CustomFormField(
                            obsecureText: true,
                            textEditingController: pwConfirmController,
                            textHint: 'Masukkan Password',
                            suffixIcon: Icons.visibility_rounded),
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
                              setState(() {
                                _onSend = true;
                              });

                              if (_formKey.currentState!.validate()) {
                                if (pwController.text !=
                                        pwConfirmController.text ||
                                    !validPassword) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Password tidak valid"),
                                    ),
                                  );
                                } else {
                                  ForgotPasswordResponse res =
                                      await forgotPasswordProvider
                                          .changePassword(
                                    email: widget.email,
                                    password: pwController.text,
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
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                      LoginPage.routeName,
                                      (route) => false,
                                    );
                                  }
                                }
                              }

                              setState(() {
                                _onSend = false;
                              });
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
