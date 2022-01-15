import 'package:flutter/material.dart';
import 'package:smartville/common/text_styles.dart';
import 'package:smartville/model/news_response.dart';

class ListPengumuman extends StatefulWidget {
  const ListPengumuman({Key? key, required this.pengumumanList})
      : super(key: key);

  final List<Datum> pengumumanList;
  @override
  _ListPengumumanState createState() => _ListPengumumanState();
}

class _ListPengumumanState extends State<ListPengumuman> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) => Container(
        width: 215,
        height: 120,
        margin: const EdgeInsets.only(right: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(children: [
            ShaderMask(
              shaderCallback: (rectangle) => const LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Color(0xFF0DAF97), Color(0x000DAF97)],
              ).createShader(
                  Rect.fromLTRB(0, 0, rectangle.width, rectangle.height)),
              blendMode: BlendMode.darken,
              child: Image.network(
                widget.pengumumanList[index].fotoBerita ?? "",
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Positioned(
              bottom: 20,
              left: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.pengumumanList[index].judulBerita ?? "",
                    style: primaryText.copyWith(
                        fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                  Text(
                    widget.pengumumanList[index].deskripsiBerita ?? "",
                    style: primaryText.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
      itemCount: widget.pengumumanList.length,
    );
  }
}
