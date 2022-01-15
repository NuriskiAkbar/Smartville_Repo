import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:smartville/common/colors.dart';
import 'package:smartville/common/constant.dart';
import 'package:smartville/common/text_styles.dart';
import 'package:smartville/model/user_response.dart';
import 'package:smartville/pages/dashboard_page.dart';
import 'package:smartville/pages/forgot_password_page.dart';
import 'package:smartville/provider/user_provider.dart';
import 'package:smartville/widgets/custom_form_field.dart';
import './register_page_1.dart';

class LoginPage extends StatefulWidget {
  static const routeName = 'login';
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _onSend = false;

  Future<void> _login() async {
    setState(() => _onSend = true);
    UserProvider provider = context.read<UserProvider>();
    User auth = await provider.login(
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (auth.data?.token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            auth.message,
          ),
        ),
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        DashboardPage.routeName,
        (Route<dynamic> route) => false,
      );
    }
    setState(() => _onSend = false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF017262),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo.png',
                  ),
                  const SizedBox(height: 30),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: defaultMargin),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            'Selamat Datang!',
                            style: primaryText.copyWith(fontSize: 28),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Masuk untuk melanjutkan',
                            style: greyText,
                          ),
                          const SizedBox(height: 45),
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomFormField(
                                  textEditingController: _emailController,
                                  textHint: 'Email',
                                  prefixIcon: Icons.mail_outline,
                                  enable: !_onSend,
                                ),
                                const SizedBox(height: 30),
                                CustomFormField(
                                  textEditingController: _passwordController,
                                  textHint: 'Password',
                                  obsecureText: true,
                                  prefixIcon: Icons.lock_outline,
                                  suffixIcon: Icons.visibility,
                                  enable: !_onSend,
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (!_onSend) {
                                      Navigator.pushNamed(context,
                                          ForgotPasswordPage.routeName);
                                    }
                                  },
                                  child: Text(
                                    "Lupa Password?",
                                    style: primaryText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: _onSend
                                ? const LinearProgressIndicator()
                                : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: primaryColor,
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        _login();
                                      }
                                    },
                                    child: Text(
                                      'Masuk',
                                      style: blackText.copyWith(fontSize: 16),
                                    ),
                                  ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text("Belum punya akun?"),
                              TextButton(
                                child: Text(
                                  "Daftar",
                                  style: primaryText.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(10, 30),
                                  alignment: Alignment.centerLeft,
                                ),
                                onPressed: () {
                                  if (!_onSend) {
                                    Navigator.pushNamed(
                                        context, RegisterPage1.routeName);
                                  }
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
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
