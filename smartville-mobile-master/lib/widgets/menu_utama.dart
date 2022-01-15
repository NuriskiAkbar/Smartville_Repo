import 'package:flutter/material.dart';
import 'package:smartville/common/text_styles.dart';
import 'package:smartville/pages/citizen_data_menu.dart';
import 'package:smartville/pages/pelaporan_warga_page.dart';
import 'package:smartville/pages/pendataan_kelahiran_page.dart';
import 'package:smartville/pages/permohonan_surat_pengantar_page.dart';
import 'package:smartville/pages/request_support_page.dart';

class MenuUtama extends StatelessWidget {
  const MenuUtama({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //Menu 1
        TextButton(
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF70C7BA),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Row(
              children: [
                Image.asset('assets/icons/dokumen.png'),
                const SizedBox(width: 8),
                Text(
                  'Permohonan Surat Pengantar',
                  style: primaryText.copyWith(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(
                context, PermohohonanSuratPengantarPage.routeName);
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            alignment: Alignment.centerLeft,
          ),
        ),
        //Menu 2
        const SizedBox(height: 10),
        TextButton(
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF70C7BA),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Row(
              children: [
                Image.asset('assets/icons/warga.png'),
                const SizedBox(width: 8),
                Text(
                  'Pendataan Warga Desa',
                  style: primaryText.copyWith(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(context, CitizenDataMenu.routeName);
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            alignment: Alignment.centerLeft,
          ),
        ),
        //Menu 3
        const SizedBox(height: 10),
        TextButton(
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF70C7BA),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Row(
              children: [
                Image.asset('assets/icons/permohonan.png'),
                const SizedBox(width: 8),
                Text(
                  'Permohonan Bantuan Desa',
                  style: primaryText.copyWith(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(context, RequestSupportPage.routeName);
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            alignment: Alignment.centerLeft,
          ),
        ),
        //Menu 4
        const SizedBox(height: 10),
        TextButton(
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF70C7BA),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Row(
              children: [
                Image.asset('assets/icons/pelaporan.png'),
                const SizedBox(width: 8),
                Text(
                  'Pengaduan',
                  style: primaryText.copyWith(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(context, PelaporanWargaPage.routeName);
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            alignment: Alignment.centerLeft,
          ),
        ),
      ],
    );
  }
}
