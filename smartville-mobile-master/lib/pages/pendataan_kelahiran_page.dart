import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';
import 'package:smartville/common/colors.dart';
import 'package:smartville/common/text_styles.dart';
import 'package:smartville/model/notification_message.dart';
import 'package:smartville/model/pendataan_kelahiran_response.dart';
import 'package:smartville/provider/pendataan_kelahiran_provider.dart';
import 'package:smartville/provider/user_provider.dart';
import 'package:smartville/widgets/custom_dialog.dart';
import 'package:smartville/widgets/custom_form_field.dart';

import 'notifikasi_berhasil_page.dart';

class PendataanKelahiranPage extends StatefulWidget {
  const PendataanKelahiranPage({Key? key}) : super(key: key);
  static const routeName = 'pendataan_kelahiran_page';

  @override
  _PendataanKelahiranPageState createState() => _PendataanKelahiranPageState();
}

enum JenisKelamin { L, P }

class _PendataanKelahiranPageState extends State<PendataanKelahiranPage> {
  TextEditingController namaBayiController = TextEditingController();
  TextEditingController namaAyahController = TextEditingController();
  TextEditingController namaIbuController = TextEditingController();
  TextEditingController anakKeController = TextEditingController();
  TextEditingController waktuKelahiranController = TextEditingController();
  TextEditingController alamatKelahiranController = TextEditingController();
  TextEditingController tanggalKelahiranController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _onSend = false;
  String? tanggalFormatted;
  String? tanggalWaktu;


  String getTime(){

      if(tanggalFormatted != null && waktuKelahiranController.text != null){
        return tanggalWaktu = '$tanggalFormatted ${waktuKelahiranController.text}';
      }
      else{
        return '';
      }



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
        tanggalFormatted = DateFormat("yyyy-MM-dd").format(_selectedDate);
        print(tanggalFormatted);
      });
    }
  }

  TimeOfDay? time;

  Future _selectTime(
      BuildContext context, TextEditingController controller) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
        context: context, initialTime: time ?? initialTime);

    if (newTime == null) return;
    setState(() {
      time = newTime;
      controller.text =
          '${time!.hour.toString().padLeft(2, '0')}:${time!.minute.toString().padLeft(2, '0')}:00';
      print(controller.text);
    });
  }

  JenisKelamin? _jenisKelamin = JenisKelamin.L;

  Future<void> pendataanKelahiran(
    String namaBayi,
    String namaAyah,
    String namaIbu,
    bool jenisKelamin,
    int anakKe,
    String tanggalKelahiran,
    String alamatKelahiran,
  ) async {
    setState(() {
      _onSend = true;
    });
    UserProvider userProvider = context.read<UserProvider>();
    PendataanKelahiranProvider provider =
        context.read<PendataanKelahiranProvider>();
    String token = userProvider.token ?? "";
    PendataanKelahiran pendataanKelahiran =
        await provider.submitPendataanKelahiran(
            token: token,
            namaBayi: namaBayi,
            jenisKelamin: jenisKelamin,
            namaAyah: namaAyah,
            namaIbu: namaIbu,
            anakKe: anakKe,
            tanggalKelahiran: tanggalKelahiran,
            alamatKelahiran: alamatKelahiran,
            registrationToken: userProvider.tokenFCM!);
    if (pendataanKelahiran.error == false) {
      NotificationMessage notificationMessage = NotificationMessage(
        imageAssets: 'assets/celebration.png',
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
            pendataanKelahiran.message ?? "",
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            pendataanKelahiran.message ?? "",
          ),
        ),
      );
    }
    setState(() => _onSend = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF70C7BA),
        appBar: AppBar(
          title: Text('Pendataan Kelahiran', style: whiteText),
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
                              'Nama Lengkap Bayi',
                              style: greyText,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            CustomFormField(
                                textEditingController: namaBayiController,
                                textHint: 'Masukkan Nama Lengkap Bayi'),
                            const SizedBox(height: 20),
                            Text(
                              'Jenis Kelamin',
                              style: greyText,
                            ),
                            const SizedBox(height: 4),
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
                              'Nama Ayah Kandung',
                              style: greyText,
                            ),
                            const SizedBox(height: 4),
                            CustomFormField(
                                textEditingController: namaAyahController,
                                textHint: 'Masukkan Nama Ayah Kandung'),
                            const SizedBox(height: 20),
                            Text(
                              'Nama Ibu Kandung',
                              style: greyText,
                            ),
                            const SizedBox(height: 4),
                            CustomFormField(
                                textEditingController: namaIbuController,
                                textHint: 'Masukkan Nama Ibu Kandung'),
                            const SizedBox(height: 20),
                            Text(
                              'Anak Ke-',
                              style: greyText,
                            ),
                            const SizedBox(height: 4),
                            CustomFormField(
                                typeNumber: true,
                                textEditingController: anakKeController,
                                textHint: 'Anak Ke-'),
                            const SizedBox(height: 20),
                            Text(
                              'Tanggal Kelahiran',
                              style: greyText,
                            ),
                            const SizedBox(height: 4),
                            CustomFormField(
                              textEditingController: tanggalKelahiranController,
                              textHint: 'Masukan Tanggal Kelahiran',
                              readOnly: true,
                              onTap: () {
                                _selectDate(
                                    context, tanggalKelahiranController);
                              },
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Waktu Kelahiran',
                              style: greyText,
                            ),
                            const SizedBox(height: 4),
                            CustomFormField(
                              textEditingController: waktuKelahiranController,
                              textHint: 'Masukan Waktu Kelahiran',
                              readOnly: true,
                              onTap: () {
                               _selectTime(context, waktuKelahiranController);
                              },
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Alamat Kelahiran',
                              style: greyText,
                            ),
                            const SizedBox(height: 4),
                            CustomFormField(
                              textEditingController: alamatKelahiranController,
                              textHint: 'Masukkan Alamat Kelahiran',
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
                                          if (_formKey.currentState!
                                              .validate()) {
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  CustomDialog(
                                                text:
                                                    "Apakah Anda yakin data yang dimasukan sudah benar ?",
                                                onClick: () {
                                                  pendataanKelahiran(
                                                    namaBayiController.text,
                                                    namaAyahController.text,
                                                    namaIbuController.text,
                                                    (_jenisKelamin ==
                                                            JenisKelamin.L
                                                        ? true
                                                        : false),
                                                    int.parse(
                                                        anakKeController.text),
                                                   getTime(),
                                                    alamatKelahiranController
                                                        .text,
                                                  );
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            );
                                            print(tanggalFormatted);
                                          }
                                        },
                                        child: Text(
                                          'Submit',
                                          style:
                                              blackText.copyWith(fontSize: 16),
                                        ),
                                      )),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
