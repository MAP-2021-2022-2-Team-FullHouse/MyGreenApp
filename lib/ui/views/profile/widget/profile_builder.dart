import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/profile/profile_viewmodel.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final bool isEdit;
  //final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    this.isEdit = false,
    //required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return FutureBuilder(
      future: ProfileViewmodel.getImgUrl(imagePath),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        bool error = snapshot.data == null;
        return Center(
          child: Stack(
            children: [
              buildImage(snapshot.data),
              Positioned(
                bottom: 0,
                right: 4,
                child: buildEditIcon(color),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildImage(String? data) {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: NetworkImage(data.toString()),
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(/* onTap: onClicked */),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            isEdit ? Icons.add_a_photo : Icons.edit,
            color: Colors.white,
            size: 20,
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
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
