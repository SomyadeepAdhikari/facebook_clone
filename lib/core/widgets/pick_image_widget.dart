import 'dart:io';

import 'package:flutter/material.dart';

class PickImageWidget extends StatelessWidget {
  const PickImageWidget({super.key, required this.image});
  final File? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey,width: 1),
        shape: BoxShape.circle
      ),
      child: Stack(
        children: [
          image != null?
            CircleAvatar(
              radius: 50,
              backgroundImage: FileImage(image!),
            )
          :
            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.camera_alt, size: 50),
              // backgroundImage: NetworkImage(Constants.maleProfilePic),
            ),
          Positioned(
            bottom: 0,
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                // Implement image picking logic here
              },
            ),
          ),
        ],
      ),
    );
  }
}