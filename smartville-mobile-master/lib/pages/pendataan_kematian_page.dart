import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';
import 'package:smartville/common/colors.dart';
import 'package:smartville/common/text_styles.dart';
import 'package:smartville/model/notification_message.dart';
import 'package:smartville/model/pendataan_kematian_response.dart';
import 'package:smartville/provider/pendataan_kematian_provider.dart';
import 'package:smartville/provider/user_provider.dart';
import 'package:smartville/widgets/custom_dialog.dart';
import 'package:smartville/widgets/custom_form_field.dart';

import 'notifikasi_berhasil_page.dart';

class PendataanKematianPage extends StatefulWidget {
  const PendataanKematianPage({Key? key}) : super(key: key);

  static const routeName = 'pendataan_kematian_page';

  @override
  _PendataanKematianPageState createState() => _PendataanKematianPageState();
}

enum JenisKelamin { L, P }

class _PendataanKematianPageState extends State<PendataanKematianPage> {
  TextEditingController nikController = TextEditingController();
  TextEditingController usiaController = TextEditingController();
  TextEditingController tanggalWafatController = TextEditingController();
  TextEditingController namaAlmarhumController = TextEditingController();
  TextEditingController alamatAlmarhumController = TextEditingController();

  JenisKelamin? _jenisKelamin = JenisKelamin.L;
  String? tanggalFormatted;
  bool _onSend = false;

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


  Future<void> pendataanKematian(
      String nik,
      String nama,
      bool jenisKelamin,
      int usia,
      String tglWafat,
      String alamat,
      ) async {
    setState(() {
      _onSend = true;
    });
    UserProvider userProvider = context.read<UserProvider>();
    PendataanKematianProvider provider =
    context.read<PendataanKematianProvider>();
    String token = userProvider.token ?? "";
    PendataanKematian pendataanKematian =
    await provider.submitPendataanKematian(
        token: token,
        nik: nik,
        nama: nama,
        jenisKelamin: jenisKelamin,
        usia: usia,
        tglWafat: tglWafat,
        alamat: alamat,
        registerToken: userProvider.tokenFCM!);
    if (pendataanKematian.error == false) {
      NotificationMessage notificationMessage = NotificationMessage(
        imageAssets: 'assets/angel.png',
        title: "Pelaporan Terkirim!",
        message:
        "Pelaporan telah dikirim. Silahkan tunggu notifikasi dari admin untuk tindak lanjut. ",
        textButton: "Kembali ke halaman dashboard",
        navigateTo: "dashboard",
      );
      Navigator.pushNamed(context, NotifikasiBerhasilPage.routeName,
          arguments: notificationMessage);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            pendataanKematian.message ?? "",
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            pendataanKematian.message ?? "",
          ),
        ),
      );
    }
    setState(() => _onSend = false);
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF70C7BA),
      appBar: AppBar(
        title: Text('Pendataan Kematian', style: whiteText),
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
                            textEditingController: nikController,
                            textHint: 'Masukkan NIK',
                            maxLength: 16,
                            typeNumber: true,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Nama Almarhum',
                            style: greyText,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          CustomFormField(
                              textEditingController: namaAlmarhumController,
                              textHint: 'Masukan nama Almarhum / Almarhumah'),
                          const SizedBox(height: 20),
                          Text(
                            'Jenis Kelamin',
                            style: greyText,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  margin: const EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFDEEDEB),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    children: [
                                      Radio<JenisKelamin>(
                                        value: JenisKelamin.L,
                                        groupValue: _jenisKelamin,
                                        onChanged: (JenisKelamin? value) {
                                          setState(() {
                                            _jenisKelamin = value;
                                          });
                                        },
                                      ),
                                      Text('Laki-Laki', style: greyText)
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  margin: const EdgeInsets.only(left: 8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFDEEDEB),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    children: [
                                      Radio<JenisKelamin>(
                                        value: JenisKelamin.P,
                                        groupValue: _jenisKelamin,
                                        onChanged: (JenisKelamin? value) {
                                          setState(() {
                                            _jenisKelamin = value;
                                          });
                                        },
                                      ),
                                      Text('Perempuan', style: greyText)
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Usia',
                            style: greyText,
                          ),
                          const SizedBox(height: 4),
                          CustomFormField(
                              typeNumber: true,
                              textEditingController: usiaController,
                              textHint: 'Masukkan Usia'),
                          const SizedBox(height: 20),
                          Text(
                            'Tanggal Wafat',
                            style: greyText,
                          ),
                          const SizedBox(height: 4),
                          CustomFormField(
                            textEditingController: tanggalWafatController,
                            textHint: 'Masukan Tanggal Kematian',
                            readOnly: true,
                            onTap: () {
                              _selectDate(context, tanggalWafatController);
                            },
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Alamat Almarhum',
                            style: greyText,
                          ),
                          const SizedBox(height: 4),
                          CustomFormField(
                            textEditingController: alamatAlmarhumController,
                            textHint: 'Masukan Alamat Almarhum',
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
                                          pendataanKematian(
                                              nikController.text,
                                              namaAlmarhumController.text,
                                              _jenisKelamin ==
                                                  JenisKelamin.L
                                                  ? true
                                                  : false,
                                              int.parse(
                                                  usiaController.text),
                                              tanggalFormatted!,
                                              alamatAlmarhumController
                                                  .text);
                                          Navigator.pop(context);
                                        }),
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
