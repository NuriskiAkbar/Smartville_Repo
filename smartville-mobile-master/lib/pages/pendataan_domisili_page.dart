import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';
import 'package:smartville/common/colors.dart';
import 'package:smartville/common/text_styles.dart';
import 'package:smartville/model/notification_message.dart';
import 'package:smartville/model/pendataan_domisili_response.dart';
import 'package:smartville/provider/pendataan_domisili_provider.dart';
import 'package:smartville/provider/user_provider.dart';
import 'package:smartville/widgets/custom_dialog.dart';
import 'package:smartville/widgets/custom_form_field.dart';

import 'notifikasi_berhasil_page.dart';

class PendataanDomisiliPage extends StatefulWidget {
  const PendataanDomisiliPage({Key? key}) : super(key: key);

  static const routeName = 'pendataan_domisili_page';

  @override
  _PendataanDomisiliPageState createState() => _PendataanDomisiliPageState();
}

class _PendataanDomisiliPageState extends State<PendataanDomisiliPage> {
  TextEditingController nikPemohonController = TextEditingController();
  TextEditingController namaPemohonController = TextEditingController();
  TextEditingController tglLahirController = TextEditingController();
  TextEditingController asalDomisiliController = TextEditingController();
  TextEditingController tujuanDomisiliController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? tanggalFormatted;
  bool _onSend = false;
  bool isChecked = false;

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
        tanggalFormatted = DateFormat("yyyyMMdd").format(_selectedDate);
        print(tanggalFormatted);
      });
    }
  }

  Future<void> _submitPendataanDomisili(String nikPemohon, String namaPemohon,
      String tglLahir, String asalDomisili, String tujuanDomisili) async {
    setState(() => _onSend = true);
    UserProvider userProvider = context.read<UserProvider>();
    PendataanDomisiliProvider pendataanDomisiliProvider =
    context.read<PendataanDomisiliProvider>();
    String token = userProvider.token ?? "";
    PendataanDomisili pendataanDomisili =
    await pendataanDomisiliProvider.submitPendataanDomisili(
        token: token,
        nikPemohon: nikPemohon,
        namaPemohon: namaPemohon,
        tglLahir: tglLahir,
        asalDomisili: asalDomisili,
        tujuanDomisili: tujuanDomisili,
        registerToken: userProvider.tokenFCM!);

    if (pendataanDomisili.error == false) {
      NotificationMessage notificationMessage = NotificationMessage(
        imageAssets: 'assets/celebration.png',
        title: "Permohonan Terkirim!",
        message:
        "Permohonan telah dikirim. Silahkan tunggu notifikasi dari admin.",
        textButton: "Kembali ke halaman dashboard",
        navigateTo: "dashboard",
      );
      Navigator.pushNamed(context, NotifikasiBerhasilPage.routeName,
          arguments: notificationMessage);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            pendataanDomisili.message ?? "",
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            pendataanDomisili.message ?? "",
          ),
        ),
      );
    }
    setState(() => _onSend = false);
  }

  Future isiDataSaya() async {
    UserProvider userProvider = context.read<UserProvider>();
    nikPemohonController.text = userProvider.userNik!;
    namaPemohonController.text = userProvider.userName!;
    asalDomisiliController.text = userProvider.userAlamat!;
  }
  _resetForm() {
    _formKey.currentState?.reset();
    nikPemohonController.clear();
    namaPemohonController.clear();
    asalDomisiliController.clear();

  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Color(0xFFF38263);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF70C7BA),
      appBar: AppBar(
        title: Text('Pendataan Domisili', style: whiteText),
        backgroundColor: const Color(0xFF70C7BA),
        elevation: 0.0,
        leading: const BackButton(color: Colors.white),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.popUntil(
                    context, (Route<dynamic> route) => route.isFirst);
              },
              icon: Image.asset('assets/icons/home.png'))
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Flexible(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
                color: Colors.white,
              ),
              height: double.infinity,
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 40.0,
                        horizontal: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'NIK',
                            style: greyText,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          CustomFormField(
                            textEditingController: nikPemohonController,
                            textHint: 'Masukkan NIK',
                            maxLength: 16,
                            typeNumber: true,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Checkbox(
                                value: isChecked,
                                fillColor: MaterialStateProperty.resolveWith(
                                    getColor),
                                onChanged: (val) {
                                  setState(() {
                                    isChecked = val!;
                                  });
                                  if (isChecked) {
                                    isiDataSaya();
                                  } else {
                                    _resetForm();
                                  }
                                },
                                activeColor: Colors.white,
                              ),
                              InkWell(
                                child: Text(
                                  'Centang untuk pakai data saya',
                                  style: orangeText.copyWith(
                                      fontSize: 12,
                                      decoration: TextDecoration.underline),
                                ),
                                onTap: () {
                                  setState(() {
                                    !isChecked;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Nama',
                            style: greyText,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          CustomFormField(
                              textEditingController: namaPemohonController,
                              textHint: 'Masukkan Nama'),
                          const SizedBox(height: 20),
                          Text(
                            'Tanggal Lahir',
                            style: greyText,
                          ),
                          const SizedBox(height: 4),
                          CustomFormField(
                            textEditingController: tglLahirController,
                            textHint: 'Masukan Tanggal Lahir',
                            readOnly: true,
                            onTap: () {
                              _selectDate(context, tglLahirController);
                            },
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Asal Domisili',
                            style: greyText,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          CustomFormField(
                            textEditingController: asalDomisiliController,
                            textHint: 'Masukkan Asal Domisili',
                            typeMultiline: true,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Tujuan Domisili',
                            style: greyText,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          CustomFormField(
                            textEditingController: tujuanDomisiliController,
                            textHint: 'Masukkan Tujuan Domisili',
                            typeMultiline: true,
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: _onSend
                                ? const LinearProgressIndicator()
                                : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: primaryColor,
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => CustomDialog(
                                      text:
                                      "Apakah Anda yakin data yang dimasukan sudah benar ?",
                                      onClick: () {
                                        _submitPendataanDomisili(
                                            nikPemohonController.text,
                                            namaPemohonController.text,
                                            tanggalFormatted!,
                                            asalDomisiliController.text,
                                            tujuanDomisiliController
                                                .text);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  );
                                }
                              },
                              child: Text('Submit',
                                  style:
                                  blackText.copyWith(fontSize: 16)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
