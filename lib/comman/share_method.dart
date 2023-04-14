
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

Future<void> share(BuildContext context, {String text, Uint8List img}) async {
  final RenderBox box = context.findRenderObject();
  final String textMsg =
      '${text ?? ''}\nhttps://www.johansford.com/services/colour/';
  if (img == null) {
    Share.share(textMsg,
        subject: 'N/A',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  } else {
    String image =await convertByteToFile(img);
    Share.shareFiles([image],
        text: textMsg,
        subject: 'N/A',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}

Future<String> convertByteToFile(Uint8List uint8list)async{
  final directory = await getApplicationDocumentsDirectory();
  final imagePath =
      await File('${directory.path}/image.png').create();
  await imagePath.writeAsBytes(uint8list);
  return imagePath.path;
}
