import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Imgpckr extends StatefulWidget {
  const Imgpckr({Key? key}) : super(key: key);

  @override
  _ImgpckrState createState() => _ImgpckrState();
}

class _ImgpckrState extends State<Imgpckr> {
  File? image;
  Future camera(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }
  // File? image;
  // Future camera() async {
  //   var img = await ImagePicker().pickImage(source: ImageSource.camera);
  //   setState(() {
  //     image = img as File?;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.blueGrey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width / 1.5,
                child: image != null
                    ? Image.file(
                        image!,
                        fit: BoxFit.fill,
                      )
                    : FlutterLogo(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton.extended(
                      onPressed: () {
                        camera(ImageSource.camera);
                      },
                      label: Row(
                        children: [Icon(Icons.camera), Text("Camera")],
                      )),
                  FloatingActionButton.extended(
                      onPressed: () {
                        camera(ImageSource.gallery);
                      },
                      label: Row(
                        children: [Icon(Icons.photo), Text("Gallery")],
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
