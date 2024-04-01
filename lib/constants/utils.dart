import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';


//show thong bao thanh cong
void showSucccessDialog(BuildContext context, String text) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.success,
    animType: AnimType.bottomSlide,
    showCloseIcon: true,
    title: text, 
  ).show();

  Future.delayed(const Duration(seconds: 2), () {
    Navigator.of(context).pop();
  });
}
//show thong bao that bai

void showErrorDialog(BuildContext context, String text) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.error,
    animType: AnimType.bottomSlide,
    showCloseIcon: true,
    title: text, 
  ).show();

  Future.delayed(const Duration(seconds: 2), () {
    Navigator.of(context).pop();
  });
}
Future<List<File>> pickImages() async {
  List<File> images = [];
  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        images.add(File(files.files[i].path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}
