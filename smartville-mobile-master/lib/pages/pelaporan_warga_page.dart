import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:smartville/common/colors.dart';
import 'package:smartville/common/text_styles.dart';
import 'package:smartville/model/notification_message.dart';
import 'package:smartville/model/pelaporan_response.dart';
import 'package:smartville/pages/notifikasi_berhasil_page.dart';
import 'package:smartville/provider/pelaporan_warga_provider.dart';
import 'package:smartville/provider/user_provider.dart';
import 'package:smartville/widgets/custom_dialog.dart';
import 'package:smartville/widgets/custom_form_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/src/provider.dart';
import 'package:smartville/widgets/custom_select_option.dart';

class PelaporanWargaPage extends StatefulWidget {
  const PelaporanWargaPage({Key? key}) : super(key: key);
  static const routeName = 'pelaporan_warga_page';

  @override
  _PelaporanWargaPageState createState() => _PelaporanWargaPageState();
}

class _PelaporanWargaPageState extends State<PelaporanWargaPage> {
  TextEditingController namaPelaporController = TextEditingController();
  TextEditingController keteranganKejadianController = TextEditingController();
  TextEditingController noHpController = TextEditingController();
  TextEditingController jenisLaporanController = TextEditingController();
  TextEditingController tanggalLaporanController = TextEditingController();
  TextEditingController alamatKejadianController = TextEditingController();
  TextEditingController jenisLaporanLainnyaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _onSend = false;
  File? image;
  String? tanggalFormatted;
  bool jenisLaporanLainnya = false;
  Future _pickImage(ImageSource source) async {
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

  Future<void> pelaporan(
      String namaPelapor,
      String keteranganKejadian,
      String jenisLaporan,
      String tanggalLaporan,
      String noHp,
      String alamatLaporan,
      File dokumentasiKejadian) async {
    setState(() => _onSend = true);
    UserProvider userProvider = context.read<UserProvider>();
    PelaporanWargaProvider provider = context.read<PelaporanWargaProvider>();
    String token = userProvider.token ?? "";
    String registrationToken = userProvider.tokenFCM ?? "";
    Pelaporan pelaporan = await provider.submitLaporan(
      token: token,
      namaPelapor: namaPelapor,
      keteranganKejadian: keteranganKejadian,
      jenisLaporan: jenisLaporan,
      tanggalLaporan: tanggalLaporan,
      noHp: noHp,
      alamatLaporan: alamatLaporan,
      dokumentasiKejadian: dokumentasiKejadian,
      registrationToken: registrationToken,
    );
    if (pelaporan.error == false) {
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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            pelaporan.message ?? "",
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
        title: Text(
          'Pengaduan Warga',
          style: whiteText.copyWith(fontSize: 14),
        ),
        backgroundColor: const Color(0xFF70C7BA),
        elevation: 0.0,
        leading: const BackButton(color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Flexible(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30),
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
                              'Nama Pelapor',
                              style: greyText,
                            ),
                            const SizedBox(height: 4),
                            CustomFormField(
                              textEditingController: namaPelaporController,
                              textHint: 'Masukan Nama Pelapor',
                              maxLength: 16,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Keterangan Kejadian',
                              style: greyText,
                            ),
                            CustomFormField(
                              textEditingController:
                                  keteranganKejadianController,
                              textHint: 'Masukan keterangan kejadian',
                              typeMultiline: true,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Jenis Laporan',
                              style: greyText,
                            ),
                            CustomSelectOption(
                              items: const [
                                'Kehilangan',
                                'Pencurian',
                                'Penculikan',
                                'Lainnya'
                              ],
                              onChanged: (val) {
                                jenisLaporanController.text = val ?? "";
                                if (val == "Lainnya") {
                                  setState(() {
                                    jenisLaporanLainnya = true;
                                  });
                                } else {
                                  setState(() {
                                    jenisLaporanLainnya = false;
                                  });
                                }
                              },
                            ),
                            jenisLaporanLainnya
                                ? const SizedBox(height: 20)
                                : const SizedBox(height: 0),
                            jenisLaporanLainnya
                                ? Text(
                                    'Isi Jenis Laporan Lainnya',
                                    style: greyText,
                                  )
                                : const SizedBox(height: 0),
                            jenisLaporanLainnya
                                ? CustomFormField(
                                    textEditingController:
                                        jenisLaporanLainnyaController,
                                    textHint: 'Masukan jenis laporan lainnya',
                                  )
                                : const SizedBox(height: 0),
                            const SizedBox(height: 20),
                            Text(
                              'Tanggal Laporan',
                              style: greyText,
                            ),
                            CustomFormField(
                              textEditingController: tanggalLaporanController,
                              textHint: 'Masukan tanggal laporan',
                              readOnly: true,
                              onTap: () {
                                _selectDate(context, tanggalLaporanController);
                              },
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'No. Hp',
                              style: greyText,
                            ),
                            CustomFormField(
                              typeNumber: true,
                              textEditingController: noHpController,
                              textHint: 'Masukan No Hp',
                              maxLength: 12,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Alamat laporan',
                              style: greyText,
                            ),
                            CustomFormField(
                              textEditingController: alamatKejadianController,
                              textHint: 'Masukan alamat',
                              typeMultiline: true,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Dokumentasi Kejadian',
                              style: greyText,
                            ),
                            image != null
                                ? Image.file(
                                    image!,
                                    width: double.infinity,
                                    height: 200,
                                  )
                                : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: const Color(0xFFCFD7D5),
                                    ),
                                    onPressed: () {
                                      _pickImage(ImageSource.gallery);
                                    },
                                    child: Text(
                                      'Choose File',
                                      style: blackText.copyWith(
                                          fontSize: 16,
                                          color: const Color(0xFF888A8A)),
                                    ),
                                  ),
                            const SizedBox(
                              height: 20,
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
                                        if (_formKey.currentState!.validate()) {
                                          if (image == null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "Isi dokumentasi kejadian terlebih dahulu",
                                                ),
                                              ),
                                            );
                                          } else {
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  CustomDialog(
                                                text:
                                                    "Apakah Anda yakin data yang dimasukan sudah benar ?",
                                                onClick: () {
                                                  String jenisLaporan =
                                                      jenisLaporanLainnyaController
                                                              .text.isNotEmpty
                                                          ? jenisLaporanLainnyaController
                                                              .text
                                                          : jenisLaporanController
                                                              .text;
                                                  pelaporan(
                                                    namaPelaporController.text,
                                                    keteranganKejadianController
                                                        .text,
                                                    jenisLaporan,
                                                    tanggalFormatted!,
                                                    noHpController.text,
                                                    alamatKejadianController
                                                        .text,
                                                    image!,
                                                  );
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      child: Text(
                                        'Submit',
                                        style: blackText.copyWith(fontSize: 16),
                                      ),
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
      ),
    );
  }
}
