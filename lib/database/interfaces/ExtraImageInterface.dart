import 'dart:typed_data';

import 'package:project_flutter/database/tables/IngredientCategoryTable.dart';

import '../../domain/ExtraImage.dart';
import '../DBHelper.dart';
import '../tables/ExtraImageTable.dart';

class ExtraImageInterface {
  static Future<List<ExtraImage>> getItems() async {
    final db = DBHelper.getDB();
    var columns = ExtraImageTable.COLUMNS_FOR_SELECT;

    final res = await db.query(
      ExtraImageTable.TABLE_NAME,
      columns: columns,
    );

    List<ExtraImage> images = [];

    res.forEach((Map<String, Object?> map) {
      var id = map[ExtraImageTable.COLUMN_ID] as int;
      var imageList = map[ExtraImageTable.COLUMN_IMAGE] as List<int>;
      var image = Uint8List.fromList(imageList);

      images.add(ExtraImage(id: id, image: image));
    });

    return images;
  }

  static Future<void> insertItem(ExtraImage image) async {
    final db = DBHelper.getDB();
    final values = <String, Object>{ExtraImageTable.COLUMN_IMAGE: image.image};

    await db.insert(ExtraImageTable.TABLE_NAME, values);
  }
}
