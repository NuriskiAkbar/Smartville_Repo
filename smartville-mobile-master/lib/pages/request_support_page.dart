import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:smartville/common/colors.dart';
import 'package:smartville/common/text_styles.dart';
import 'package:smartville/model/notification_message.dart';
import 'package:smartville/model/request_support_response.dart';
import 'package:smartville/provider/request_support_provider.dart';
import 'package:smartville/provider/user_provider.dart';
import 'package:smartville/widgets/custom_dialog.dart';
import 'package:smartville/widgets/custom_form_field.dart';
import 'package:smartville/widgets/custom_select_option.dart';

import 'notifikasi_berhasil_page.dart';

class RequestSupportPage extends StatefulWidget {
  const RequestSupportPage({Key? key}) : super(key: key);
  static const routeName = 'requestsupport';

  @override
  State<RequestSupportPage> createState() => _RequestSupportState();
}

class _RequestSupportState extends State<RequestSupportPage> {
  TextEditingController namaBantuanController = TextEditingController();
  TextEditingController jenisBantuanController = TextEditingController();
  TextEditingController jenisBantuanLainnyaController = TextEditingController();
  TextEditingController jumlahDanaController = TextEditingController();
  TextEditingController alokasiDanaController = TextEditingController();
  TextEditingController danaTerealisasiController = TextEditingController();
  TextEditingController sisadanaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _onSend = false;
  bool jenisBantuanLainnya = false;

  Future<void> _submitFinancialHelp(
      String nama_bantuan,
      String jenis_bantuan,
      String jumlah_dana,
      String alokasi_dana,
      String dana_terealisasi,
      String sisa_dana_bantuan) async {
    setState(() => _onSend = true);

    var jumlahDanaParse = int.parse(jumlah_dana);
    assert(jumlahDanaParse is int);
    var alokasiDanaParse = int.parse(alokasi_dana);
    assert(alokasiDanaParse is int);
    var danaTerealisasiParse = int.parse(dana_terealisasi);
    assert(danaTerealisasiParse is int);
    var sisaDanaBantuanParse = int.parse(sisa_dana_bantuan);
    assert(sisaDanaBantuanParse is int);

    UserProvider userProvider = context.read<UserProvider>();
    RequestSupportProvider requestSupportProvider =
        context.read<RequestSupportProvider>();
    String token = userProvider.token ?? "";
    String registrationToken = userProvider.tokenFCM ?? "";
    RequestSupport requestSupport =
        await requestSupportProvider.submitRequestSupport(
            token: token,
            nama_bantuan: nama_bantuan,
            jenis_bantuan: jenis_bantuan,
            jumlah_dana: jumlahDanaParse,
            alokasi_dana: alokasiDanaParse,
            dana_terealisasi: danaTerealisasiParse,
            sisa_dana_bantuan: sisaDanaBantuanParse,
          registrationToken: registrationToken);

    if (requestSupport.error == false) {
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
            requestSupport.message ?? "",
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            requestSupport.message ?? "",
          ),
        ),
      );
    }
    setState(() => _onSend = false);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFF70C7BA),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10, left: 4),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      size: 33,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    'Permohonan Bantuan Desa',
                    style: whiteText.copyWith(fontSize: 20),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Flexible(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                width: width,
                child: SingleChildScrollView(

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nama Bantuan',
                              style: greyText,
                            ),
                            const SizedBox(height: 4),
                            CustomFormField(
                              textEditingController: namaBantuanController,
                              textHint: 'Masukan Nama Bantuan',
                            ),

                            const SizedBox(height: 4),
                            Text(
                              'Jenis Bantuan',
                              style: greyText,
                            ),
                            CustomSelectOption(
                              items: const [
                                'Perbaikan Jalan',
                                'Perbaikan Sekolah',
                                'Perbaikan Masjid',
                                'Lainnya'
                              ],
                              onChanged: (val) {
                                jenisBantuanController.text = val ?? "";
                                if (val == "Lainnya") {
                                  setState(() {
                                    jenisBantuanLainnya = true;
                                  });
                                } else {
                                  setState(() {
                                    jenisBantuanLainnya = false;
                                  });
                                }
                              },
                            ),
                            jenisBantuanLainnya
                                ? const SizedBox(height: 20)
                                : const SizedBox(height: 0),
                            jenisBantuanLainnya
                                ? Text(
                              'Isi Jenis Bantuan Lainnya',
                              style: greyText,
                            )
                                : const SizedBox(height: 0),
                            jenisBantuanLainnya
                                ? CustomFormField(
                              textEditingController:
                              jenisBantuanLainnyaController,
                              textHint: 'Masukan jenis bantuan lainnya',
                            )
                                : const SizedBox(height: 0),


                            /*const SizedBox(height: 4),
                            CustomFormField(
                              textEditingController: jenisBantuanController,
                              textHint: 'Masukan Jenis Bantuan',
                            ),*/
                            const SizedBox(height: 20),
                            Text(
                              'Jumlah Dana',
                              style: greyText,
                            ),
                            const SizedBox(height: 4),
                            CustomFormField(
                              textEditingController: jumlahDanaController,
                              textHint: 'Masukan Jumlah Dana',
                              typeNumber: true,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Alokasi Dana',
                              style: greyText,
                            ),
                            const SizedBox(height: 4),
                            CustomFormField(
                              textEditingController: alokasiDanaController,
                              textHint: 'Masukkan Alokasi Dana',
                              typeNumber: true,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Dana Terealisasi',
                              style: greyText,
                            ),
                            const SizedBox(height: 4),
                            CustomFormField(
                              textEditingController: danaTerealisasiController,
                              textHint: 'Masukkan Dana Yang Terealisasikan',
                              typeNumber: true,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Sisa Dana Bantuan',
                              style: greyText,
                            ),
                            const SizedBox(height: 4),
                            CustomFormField(
                              textEditingController: sisadanaController,
                              textHint: 'Masukkan Sisa Dana Bantuan',
                              typeNumber: true,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
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
                                          _submitFinancialHelp(
                                              namaBantuanController.text
                                                  .toString(),
                                              jenisBantuanController.text
                                                  .toString(),
                                              jumlahDanaController.text
                                                  .toString(),
                                              alokasiDanaController.text
                                                  .toString(),
                                              danaTerealisasiController.text
                                                  .toString(),
                                              sisadanaController.text
                                                  .toString());
                                          Navigator.pop(context);
                                        },
                                      ),
                                    );
                                  }
                                },
                                child: Text(
                                  'Simpan',
                                  style: blackText.copyWith(fontSize: 16),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),

              ),
            ),
          ],
        ),
      ),
    );
  }
}
