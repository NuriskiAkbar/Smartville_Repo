import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartville/common/colors.dart';
import 'package:smartville/common/text_styles.dart';
import 'package:smartville/pages/pendataan_domisili_page.dart';
import 'package:smartville/pages/pendataan_kelahiran_page.dart';
import 'package:smartville/pages/pendataan_kematian_page.dart';

class CitizenDataMenu extends StatefulWidget {
  const CitizenDataMenu({Key? key}) : super(key: key);
  static const routeName = 'citizen_data_menu'
      '';

  @override
  State<CitizenDataMenu> createState() => _CitizenDataMenuState();
}

class _CitizenDataMenuState extends State<CitizenDataMenu> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greenColor1,
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
                    color: greenColor,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: const BoxDecoration(
                color: greenColor1,
                borderRadius: BorderRadius.only(

                ),
              ),
              child: ListView(
                children: [
                  Center(child: Text( 'Pendataan Warga Desa',
                    style: primaryText.copyWith(
                        color: greenButton,
                        fontSize: 20, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,),),
                  const SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: (){Navigator.pushNamed(context, PendataanKelahiranPage.routeName);},
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      child: Center(
                        child: Text(
                          'Pendataan Kelahiran',
                          style: whiteText.copyWith(fontWeight: FontWeight.w700,fontSize: 15),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: greenButton,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: (){Navigator.pushNamed(context, PendataanKematianPage.routeName);},
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      child: Center(
                        child: Text(
                          'Pendataan Kematian',
                          style: whiteText.copyWith(fontWeight: FontWeight.w700,fontSize: 15),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: greenButton,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: (){Navigator.pushNamed(context, PendataanDomisiliPage.routeName);},
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      child: Center(
                        child: Text(
                          'Pendataan Domisili',
                          style: whiteText.copyWith(fontWeight: FontWeight.w700,fontSize: 15),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: greenButton,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  )
                ],

              ),
            ),
          ),
        ],
      ),
    );
  }
}
