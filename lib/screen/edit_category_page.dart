import 'package:e_commerce_api/model/category_model.dart';
import 'package:e_commerce_api/widget/custom_text_field.dart';
import 'package:flutter/material.dart';

class EditCategoryPage extends StatefulWidget {
  EditCategoryPage({super.key, required this.categoryModel});

  CategoryModel categoryModel;

  @override
  State<EditCategoryPage> createState() => _EditCategoryPageState();
}

class _EditCategoryPageState extends State<EditCategoryPage> {
  TextEditingController categoryController = TextEditingController();
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
            CustomTextField(
              controller: categoryController,
              hintText: widget.categoryModel.name,
            ),
            Text("Category Image"),
            Container(
              height: MediaQuery.of(context).size.height * .30,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image(
                  image: NetworkImage(
                      "https://apihomechef.antopolis.xyz/images/${widget.categoryModel.image}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text("Category Icon"),
            Container(
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
            ),
            ElevatedButton(onPressed: () {}, child: Text("Update Category"))
          ],
        ),
      ),
    );
  }
}
