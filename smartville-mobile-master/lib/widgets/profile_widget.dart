import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smartville/common/colors.dart';

enum TypeImage { ASSET, NETWORK, FILE }

class ProfileWidget extends StatelessWidget {
  final TypeImage typeImage;
  final IconData icon;
  final String? imageSrc;
  final File? imageFile;
  final VoidCallback onClickedImage;
  final VoidCallback onClickedIcon;
  const ProfileWidget({
    Key? key,
    this.imageFile,
    this.imageSrc,
    required this.typeImage,
    required this.icon,
    required this.onClickedImage,
    required this.onClickedIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(redColor, icon),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    var image;
    switch (typeImage) {
      case TypeImage.ASSET:
        image = AssetImage(imageSrc!);
        break;
      case TypeImage.NETWORK:
        image = NetworkImage(imageSrc!);
        break;
      case TypeImage.FILE:
        image = FileImage(imageFile!);
        break;
    }
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          fit: BoxFit.cover,
          image: image,
          width: 200,
          height: 200,
          child: InkWell(
            onTap: onClickedImage,
          ),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color, IconData icon) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 9,
          child: SizedBox(
            width: 20,
            height: 20,
            child: IconButton(
              padding: const EdgeInsets.all(0.0),
              onPressed: onClickedIcon,
              icon: Icon(
                icon,
                size: 20,
              ),
              color: Colors.white,
            ),
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          color: color,
          padding: EdgeInsets.all(all),
          child: child,
        ),
      );
}
