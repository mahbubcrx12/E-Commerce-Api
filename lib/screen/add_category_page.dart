import 'dart:convert';
import 'dart:io';

import 'package:e_commerce_api/const/const.dart';
import 'package:e_commerce_api/widget/const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:e_commerce_api/api_service/custom_api.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({Key? key}) : super(key: key);

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  TextEditingController nameController = TextEditingController();
  String? categoryFilledName;
  bool onProgress = false;

  final _formKey = GlobalKey<FormState>();

  final picker = ImagePicker();
  File? image, icon;

  Future getImageFromGallery() async {
    final pickedImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      if (pickedImage != null) {
        image = File(pickedImage.path);
        print("image found");
      } else {
        print("image not found");
      }
    });
  }

  Future getIconFromGallery() async {
    final pickedImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      if (pickedImage != null) {
        icon = File(pickedImage.path);
        print("icon found");
      } else {
        print("icon not found");
      }
    });
  }

  Future createCategory() async {
    var link = Uri.parse("${baseUrl}api/admin/category/store");
    var request = http.MultipartRequest("POST", link);
    request.headers.addAll(await CustomHttp().getHeadersWithToken());
    request.fields["name"] = nameController.text.toString();
    var imageFile = await http.MultipartFile.fromPath("image", image!.path);
    request.files.add(imageFile);
    var iconFile = await http.MultipartFile.fromPath("icon", icon!.path);
    request.files.add(iconFile);
    setState(() {
      onProgress = true;
    });
    var responce = await request.send();
    setState(() {
      onProgress = false;
    });
    var responceDataByte = await responce.stream.toBytes();
    var responceDataString = String.fromCharCodes(responceDataByte);
    var data = jsonDecode(responceDataString);
    if (responce.statusCode == 200) {
      showInToast("${data["message"]}");
      Navigator.of(context).pop();
    } else {
      showInToast("${data["message"]}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: Color(0xFF642E4C),
          centerTitle: true,
          title: Text(
            "Add Category",
            style: GoogleFonts.dancingScript(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back))),
      body: Container(
        color: Color(0xFF642E4C).withOpacity(.3),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  "Category Name",
                  style: myStyle(22, Colors.black),
                ),
                TextFormField(
                  controller: nameController,
                  onSaved: (name) {
                    categoryFilledName = name;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "*Write Category Name";
                    }
                    if (value.length < 3) {
                      return "*Write more then three word";
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "Enter Category Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          gapPadding: 4.0,
                          borderSide:
                              BorderSide(color: Color(0xFF642E4C), width: 30))),
                ),
                Text(
                  "Category Image",
                  style: myStyle(22, Colors.black),
                ),
                InkWell(
                  onTap: () {
                    getImageFromGallery();
                  },
                  child: image == null
                      ? Container(
                          height: height * .25,
                          width: width * .5,
                          color: Colors.red.withOpacity(.35),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Icon(
                              Icons.image,
                              size: 40,
                            ),
                          ),
                        )
                      : Image.file(
                          File(image!.path),
                          height: 200,
                          width: 250,
                          fit: BoxFit.cover,
                        ),
                ),
                Text(
                  "Category Icon",
                  style: myStyle(22, Colors.black),
                ),
                InkWell(
                  onTap: () {
                    getIconFromGallery();
                  },
                  child: icon == null
                      ? Container(
                          height: height * .25,
                          width: width * .5,
                          color: Colors.red.withOpacity(.35),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Icon(
                              Icons.image,
                              size: 40,
                            ),
                          ),
                        )
                      : Image.file(
                          File(icon!.path),
                          height: 200,
                          width: 250,
                          fit: BoxFit.cover,
                        ),
                ),
                Container(
                  width: width * .4,
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          if (icon == null) {
                            showInToast("please upload category icon");
                          } else if (image == null) {
                            showInToast("please upload category image");
                          } else {
                            createCategory();
                            Navigator.of(context).pop();
                          }
                        }
                      },
                      child: Center(
                        child: Text("Submit Category"),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
