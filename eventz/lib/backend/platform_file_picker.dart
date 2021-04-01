// import 'dart:html' as htmlfile;
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

typedef CallbackForFilePicker = Function(List<MyFile> files);

class PlatformFilePicker {
  startWebFilePicker(CallbackForFilePicker pickerCallback) async {
    if (kIsWeb) {
      try {
        // htmlfile.InputElement uploadInput = htmlfile.FileUploadInputElement();
        // uploadInput.click();
        // uploadInput.onChange.listen((e) {
        //   // read file content as dataURL
        //   final files = uploadInput.files;
        //   //was just checking for single file but you can check for multiple one
        //   if (files.length == 1) {
        //     final htmlfile.File file = files[0];
        //     final reader = htmlfile.FileReader();

        //     reader.onLoadEnd.listen((e) async {
        //       //to upload file we will be needing file bytes as web does not work exactly like path thing
        //       //and to fetch file name we will be needing file object
        //       //so created custom class to hold both.
        //       await pickerCallback(
        //           [MyFile(file.name, Uint8List.fromList(reader.result))]);
        //     });
        //     reader.readAsArrayBuffer(file);
        //   }
        // });
      } catch (err) {
        await pickerCallback(null);
      }
    } else {
      try {
        var objFile = await FilePicker.platform.pickFiles(type: FileType.image);
        File imgFile = File(objFile.files.first.path);
        Uint8List data = await imgFile.absolute.readAsBytes();
        MyFile file = MyFile(objFile.files.first.name, data);
        await pickerCallback([file]);
      } catch (err) {
        await pickerCallback(null);
      }
    }
  }

  getFileName(dynamic file) {
    if (kIsWeb) {
      return file.file.name;
    } else {
      return file.path
          .substring(file.path.lastIndexOf(Platform.pathSeparator) + 1);
    }
  }
}

// class FlutterWebFile {
//   htmlfile.File file;
//   Uint8List fileBytes;
//   FlutterWebFile(this.file, this.fileBytes);
// }

class MyFile {
  final String name;
  final Uint8List imageData;

  MyFile(this.name, this.imageData);
}
