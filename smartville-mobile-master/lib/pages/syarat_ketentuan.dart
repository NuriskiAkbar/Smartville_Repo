import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartville/common/colors.dart';

import 'package:smartville/common/text_styles.dart';
import 'package:bulleted_list/bulleted_list.dart';

class SyaratKetentuan extends StatefulWidget {
  const SyaratKetentuan({Key? key}) : super(key: key);
  static const routeName = 'syarat_ketentuan';

  @override
  _SyaratKetentuanState createState() => _SyaratKetentuanState();
}

class _SyaratKetentuanState extends State<SyaratKetentuan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF70C7BA),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              top: 40.0,
              left: 15.0,
              right: 30.0,
              bottom: 30.0,
            ),
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
                  width: 10,
                ),
                Text(
                  "Syarat & Ketentuan | SmartVille",
                  style: whiteText.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Syarat & ',
                    style: blackTextJudul,
                  ),
                  Text(
                    'Ketentuan ',
                    style: blackTextJudul,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Selamat Datang di Smartville ',
                    style: primaryText.copyWith(
                        fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Syarat & ketentuan yang ditetapkan di bawah ini mengatur pemakaian pelayanan yang disediakan oleh pegawai kantor kepala desa. Pengguna disarankan membaca dengan seksama karena dapat berdampak kepada hak dan kewajiban pengguna dibawah hukum.",
                    style: blackText,
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Dengan mendaftar dan/atau menggunakan aplikasi SmartVille, maka pengguna dianggap telah membaca, mengerti, memahami dan menyetujui semua isi dalam Syarat & ketentuan. Syarat & ketentuan ini merupakan bentuk kesepakatan yang dituangkan dalam sebuah perjanjian yang sah antara Pengguna dengan kantor kepala desa Pemaron. Jika pengguna tidak menyetujui salah satu, pesebagian, atau seluruh isi Syarat & ketentuan, maka pengguna tidak diperkenankan menggunakan layanan di SmartVille.",
                    style: blackText,
                    textAlign: TextAlign.justify,
                  ),
                  BulletedList(
                      listItems: const [
                        'Setiap pengguna baru diminta untuk membuat akun atau registrasi akun terlebih dahulu',
                        'Semua data yang diminta untuk registrasi WAJIB menggunakan data yang valid. Demi keamanan akun.',
                        'Hindari menggunakan data palsu atau data milik orang lain.',
                        'Aplikasi ini terhubung dengan admin yang seorang pegawai kantor kepala desa, sehingga apabila user menggunakan selesai melakukan permohonan maka akan mendapat notifikasi dari admin bahwa surat atau permohonan yang diminta sudah selesai ditindak.'
                      ],
                      bullet: const Icon(
                        Icons.brightness_1_rounded,
                        color: Colors.black,
                        size: 7,
                      ),
                      style: blackText.copyWith(color: Colors.black)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Kebijakan',
                    style: blackTextJudul,
                  ),
                  Text(
                    'Privasi ',
                    style: blackTextJudul,
                  ),
                  BulletedList(
                      listItems: const [
                        'Setiap data yang diinputkan merupakan data yang valid sesuai dengan identitas aslinya',
                        'Pengguna diharapkan menjaga kerahasiaan akun SmartVille karena setiap akun memiliki informasi pribadi sendiri.',
                        'Kami menjamin kerahasiaan data yang user inputkan ',
                      ],
                      bullet: const Icon(
                        Icons.brightness_1_rounded,
                        color: Colors.black,
                        size: 7,
                      ),
                      style: blackText.copyWith(color: Colors.black)),
                  const SizedBox(height: 10,),
                  Text(
                    "Apabila terjadi kebocoran data akun sesegera mungkin menghubungi admin untuk mengamankan data. Seperti yang disebutkan dari list di atas, pengguna diharapkan menjaga kerahasiaan akun. Untuk itu dihuimbau untuk rutin 3 bulan sekali untuk mengganti password secara berkala.",
                    style: blackText,
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 20,)

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
