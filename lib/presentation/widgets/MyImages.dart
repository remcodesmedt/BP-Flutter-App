import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:project_flutter/domain/ExtraImage.dart';

class MyImagesWidget extends StatelessWidget {
  final List<ExtraImage> images;

  const MyImagesWidget({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: images.length,
          itemBuilder: (context, index) {
            var image = images.elementAt(index);
            return MyImageWidget(
              imageData: image.image,
            );
          }),
    );
  }
}

class MyImageWidget extends StatelessWidget {
  final Uint8List imageData;

  const MyImageWidget({Key? key, required this.imageData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Image.memory(
        imageData,
        fit: BoxFit.cover,
        frameBuilder: (BuildContext context, Widget child, int? frame,
            bool wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded) {
            return child;
          }
          return AnimatedOpacity(
            opacity: frame == null ? 0 : 1,
            duration: const Duration(seconds: 1),
            curve: Curves.easeOut,
            child: child,
          );
        },
      ),
    );
  }
}
