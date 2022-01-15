import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:smartville/common/constant.dart';
import 'package:smartville/common/text_styles.dart';
import 'package:smartville/common/colors.dart';
import 'package:smartville/model/register_data.dart';
import 'package:smartville/pages/login_page.dart';
import 'package:smartville/provider/user_provider.dart';
import 'package:smartville/widgets/custom_dialog.dart';
import 'package:smartville/widgets/profile_widget.dart';
import 'package:smartville/model/register_response.dart';
import 'package:smartville/pages/dashboard_page.dart';
import 'package:provider/provider.dart';

class RegisterPage3 extends StatefulWidget {
  static const routeName = 'register_page_3';

  final RegisterData user;
  const RegisterPage3({Key? key, required this.user}) : super(key: key);

  @override
  _RegisterPage3State createState() => _RegisterPage3State();
}

class _RegisterPage3State extends State<RegisterPage3> {
  File? image;
  bool _onSend = false;

  Future<void> _register() async {
    setState(() => _onSend = true);
    UserProvider provider = context.read<UserProvider>();
    final user = widget.user;
    Register register = await provider.register(
        nik: user.nik ?? "",
        nama: user.nama ?? "",
        email: user.email ?? "",
        password: user.password ?? "",
        tglLahir: DateFormat("yyyyMMdd").format(user.tglLahir!),
        tempatLahir: user.tempatLahir ?? "",
        alamat: user.alamat ?? "",
        dusun: user.dusun ?? "",
        rt: user.rt.toString(),
        rw: user.rw.toString(),
        jenisKelamin: user.jenisKelamin! ? 1 : 0,
        noHp: user.noHp ?? "",
        profilePic: image);
    if (register.data.token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            register.message,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Registrasi Berhasil, Masuk untuk melanjutkan",
          ),
        ),
      );
      Navigator.pushNamedAndRemoveUntil(
        context,
        LoginPage.routeName,
        (Route<dynamic> route) => false,
      );
    }
    setState(() => _onSend = false);
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: const BackButton(color: primaryColor),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Satu langkah tersisa,\n${widget.user.nama}',
                    style: primaryText.copyWith(fontSize: 22),
                  ),
                ),
                const SizedBox(
                  height: 75,
                ),
                image != null
                    ? ProfileWidget(
                        typeImage: TypeImage.FILE,
                        icon: Icons.delete_outline_rounded,
                        imageFile: image,
                        onClickedImage: () => pickImage(ImageSource.gallery),
                        onClickedIcon: () => setState(() => image = null),
                      )
                    : ProfileWidget(
                        typeImage: TypeImage.ASSET,
                        imageSrc: 'assets/default_profile.png',
                        icon: Icons.edit,
                        onClickedImage: () => pickImage(ImageSource.gallery),
                        onClickedIcon: () => pickImage(ImageSource.gallery),
                      ),
                const SizedBox(
                  height: 100,
                ),
                SizedBox(
                  width: double.infinity,
                  child: _onSend
                      ? const LinearProgressIndicator()
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: primaryColor,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => CustomDialog(
                                text:
                                    "Apakah Anda yakin data yang dimasukan sudah benar ?",
                                onClick: () {
                                  _register();
                                  Navigator.pop(context);
                                },
                              ),
                            );
                          },
                          child: Text(
                            'Daftar',
                            style: blackText.copyWith(fontSize: 16),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
