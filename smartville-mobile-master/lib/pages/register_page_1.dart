import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartville/common/constant.dart';
import 'package:smartville/common/text_styles.dart';
import 'package:smartville/model/register_data.dart';
import 'package:smartville/model/register_response.dart';
import 'package:smartville/model/user_response.dart';
import 'package:smartville/pages/login_page.dart';
import 'package:smartville/pages/register_page_2.dart';
import 'package:smartville/widgets/custom_form_field.dart';
import 'package:smartville/common/colors.dart';
import 'package:intl/intl.dart';

class RegisterPage1 extends StatefulWidget {
  static const routeName = 'register_page_1';
  const RegisterPage1({Key? key}) : super(key: key);

  @override
  _RegisterPage1State createState() => _RegisterPage1State();
}

class _RegisterPage1State extends State<RegisterPage1> {
  TextEditingController nikController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController tempatLahirController = TextEditingController();
  TextEditingController tanggalLahirController = TextEditingController();
  TextEditingController alamatController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nikController.dispose();
    namaController.dispose();
    tempatLahirController.dispose();
    tanggalLahirController.dispose();
    alamatController.dispose();
    super.dispose();
  }

  _selectDate(BuildContext context, TextEditingController controller) async {
    int yearNow = DateTime.parse(DateTime.now().toString()).year;
    DateTime _selectedDate = DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1800),
      lastDate: DateTime((yearNow + 5)),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        controller.text = DateFormat('dd/MM/yyyy').format(_selectedDate);
      });
    }
  }

  _sendData() {
    final DateTime tglLahir =
        DateFormat('dd/MM/yyyy').parse(tanggalLahirController.text);
    return RegisterData(
      nik: nikController.text,
      nama: namaController.text,
      tempatLahir: tempatLahirController.text,
      tglLahir: tglLahir,
      alamat: alamatController.text,
    );
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
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      'Buat Akun',
                      style: primaryText.copyWith(fontSize: 22),
                    ),
                    Text(
                      'Daftar untuk memulai!',
                      style: greyText,
                    ),
                    const SizedBox(height: 36),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'NIK',
                            style: greyText,
                          ),
                          const SizedBox(height: 4),
                          CustomFormField(
                            textEditingController: nikController,
                            textHint: 'Masukan NIK',
                            maxLength: 16,
                            isStrictLength: true,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            typeNumber: true,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Nama Lengkap',
                            style: greyText,
                          ),
                          const SizedBox(height: 4),
                          CustomFormField(
                            textEditingController: namaController,
                            textHint: 'Masukan Nama Lengkap',
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Tempat Lahir',
                            style: greyText,
                          ),
                          const SizedBox(height: 4),
                          CustomFormField(
                            textEditingController: tempatLahirController,
                            textHint: 'Masukan tempat lahir',
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Tanggal Lahir(dd/mm/yyyy)',
                            style: greyText,
                          ),
                          const SizedBox(height: 4),
                          CustomFormField(
                            textEditingController: tanggalLahirController,
                            textHint: 'Masukan Tanggal Lahir',
                            readOnly: true,
                            onTap: () {
                              _selectDate(context, tanggalLahirController);
                            },
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Alamat',
                            style: greyText,
                          ),
                          const SizedBox(height: 4),
                          CustomFormField(
                            textEditingController: alamatController,
                            textHint: 'Masukan alamat tempat tinggal',
                          ),
                          const SizedBox(height: 20)
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: primaryColor,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            //action
                            Navigator.pushNamed(
                                context, RegisterPage2.routeName,
                                arguments: _sendData());
                          }
                        },
                        child: Text(
                          'Selanjutnya',
                          style: blackText.copyWith(fontSize: 16),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Sudah punya akun?"),
                        TextButton(
                          child: Text(
                            "Masuk",
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
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
