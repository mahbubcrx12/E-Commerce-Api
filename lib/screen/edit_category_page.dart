import 'dart:convert';
import 'dart:io';
import 'package:e_commerce_api/api_service/custom_api.dart';
import 'package:http/http.dart' as http;
import 'package:e_commerce_api/model/category_model.dart';
import 'package:e_commerce_api/widget/const.dart';
import 'package:e_commerce_api/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_api/screen/add_category_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../const/const.dart';

class EditCategoryPage extends StatefulWidget {
  EditCategoryPage({super.key, required this.categoryModel});

  CategoryModel categoryModel;

  @override
  State<EditCategoryPage> createState() => _EditCategoryPageState();
}

class _EditCategoryPageState extends State<EditCategoryPage> {
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

  // Future updateCategory() async {
  //   setState(() {
  //     onProgress = true;
  //   });
  //   final uri = Uri.parse(
  //       "https://apihomechef.antopolis.xyz/api/admin/category/${widget.categoryModel!.id}/update");
  //   var request = http.MultipartRequest("POST", uri);
  //   request.headers.addAll(
  //     await CustomHttp().getHeadersWithToken(),
  //   );
  //   request.fields['name'] = nameController!.text.toString();
  //   if (image != null) {
  //     var photo = await http.MultipartFile.fromPath('image', image!.path);
  //     print('processing');
  //     request.files.add(photo);
  //   }
  //   if (icon != null) {
  //     var _icon = await http.MultipartFile.fromPath('icon', icon!.path);
  //     print('processing');
  //     request.files.add(_icon);
  //   }
  //   var response = await request.send();
  //   print("status code issssssssssssssssssssss${response.statusCode}");

  //   var responseData = await response.stream.toBytes();
  //   var responseString = String.fromCharCodes(responseData);
  //   var data = jsonDecode(responseString);
  //   if (response.statusCode == 200) {
  //     print("responseBody1 $responseData");
  //     print('oooooooooooooooooooo');
  //     print(data['message']);
  //     setState(() {
  //       onProgress = false;
  //     });
  //     showInToast(data['message']);

  //     Navigator.pop(context);
  //     print("${response.statusCode}");
  //   } else {
  //     print("responseBody1 $responseString");
  //     showInToast("Try again please");
  //     setState(() {
  //       onProgress = false;
  //     });
  //   }
  // }
  Future updateCategory() async {
    var link = Uri.parse(
        "${baseUrl}api/admin/category/${widget.categoryModel.id}/update");
    var request = http.MultipartRequest("POST", link);
    request.headers.addAll(await CustomHttp().getHeadersWithToken());
    request.fields["name"] = nameController.text.toString();
    if (image != null) {
      var imageFile = await http.MultipartFile.fromPath("image", image!.path);
      request.files.add(imageFile);
    }
    if (icon != null) {
      var iconFile = await http.MultipartFile.fromPath("icon", icon!.path);
      request.files.add(iconFile);
    }
    setState(() {
      onProgress = true;
    });
    var responce = await request.send();
    // setState(() {
    //   onProgress = false;
    // });
    var responceDataByte = await responce.stream.toBytes();
    var responceDataString = String.fromCharCodes(responceDataByte);
    var data = jsonDecode(responceDataString);
    if (responce.statusCode == 204) {
      showInToast("${data["message"]}");
      Navigator.of(context).pop();
    } else {
      showInToast("${data["message"]}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Edit Category Page"),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 60,
              color: Colors.black12,
              child: Center(
                child: Text("ID: ${widget.categoryModel.id}"),
              ),
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
                  hintText: widget.categoryModel.name,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      gapPadding: 4.0,
                      borderSide:
                          BorderSide(color: Color(0xFF642E4C), width: 30))),
            ),
            Text("Category Image"),
            InkWell(
              onTap: () {
                getImageFromGallery();
              },
              child: image == null
                  ? Container(
                      height: MediaQuery.of(context).size.height * .30,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image(
                          image: NetworkImage(
                              "https://apihomechef.antopolis.xyz/images/${widget.categoryModel.image}"),
                          fit: BoxFit.cover,
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
            Text("Category Icon"),
            InkWell(
              onTap: () {
                getIconFromGallery();
              },
              child: icon == null
                  ? Container(
                      height: MediaQuery.of(context).size.height * .30,
                      width: MediaQuery.of(context).size.width * .7,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image(
                          image: NetworkImage(
                              "https://apihomechef.antopolis.xyz/images/${widget.categoryModel.icon}"),
                          fit: BoxFit.cover,
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
            ElevatedButton(
                onPressed: () {
                  updateCategory();
                  Navigator.of(context).pop();
                },
                child: Text("Update Category"))
          ],
        ),
      ),
    );
  }
}
