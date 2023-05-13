import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:project_flutter/database/interfaces/ExtraImageInterface.dart';
import 'package:project_flutter/domain/ExtraImage.dart';

class ExtraImageMock {
  static Future<Uint8List> imageToUint8List(String imagepath) async {
    var res = await rootBundle.load(imagepath);
    return res.buffer.asUint8List();
  }

  static Future<void> insertMocks() async {
    var img1 = await imageToUint8List("assets/images/extraimage1.png");
    var img2 = await imageToUint8List("assets/images/extraimage2.png");
    var img3 = await imageToUint8List("assets/images/extraimage3.png");
    var img4 = await imageToUint8List("assets/images/extraimage4.png");
    var img5 = await imageToUint8List("assets/images/extraimage5.png");
    var img6 = await imageToUint8List("assets/images/extraimage6.jpg");
    var img7 = await imageToUint8List("assets/images/extraimage7.png");
    var img8 = await imageToUint8List("assets/images/extraimage8.png");
    var img9 = await imageToUint8List("assets/images/extraimage9.png");
    var img10 = await imageToUint8List("assets/images/extraimage10.png");

    await ExtraImageInterface.insertItem(ExtraImage(id: 0, image: img1));
    await ExtraImageInterface.insertItem(ExtraImage(id: 0, image: img2));
    await ExtraImageInterface.insertItem(ExtraImage(id: 0, image: img3));
    await ExtraImageInterface.insertItem(ExtraImage(id: 0, image: img4));
    await ExtraImageInterface.insertItem(ExtraImage(id: 0, image: img5));
    await ExtraImageInterface.insertItem(ExtraImage(id: 0, image: img6));
    await ExtraImageInterface.insertItem(ExtraImage(id: 0, image: img7));
    await ExtraImageInterface.insertItem(ExtraImage(id: 0, image: img8));
    await ExtraImageInterface.insertItem(ExtraImage(id: 0, image: img9));
    await ExtraImageInterface.insertItem(ExtraImage(id: 0, image: img10));
  }

  static Future<List<ExtraImage>> getMocks() async {
    return await ExtraImageInterface.getItems();
  }
}
