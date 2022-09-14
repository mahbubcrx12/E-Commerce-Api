import 'package:e_commerce_api/model/category_model.dart';
import 'package:e_commerce_api/provider/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    var categoryList=Provider.of<CategoryProvider>(context).categoryList;
    return Scaffold(
      backgroundColor:Color(0xFF642E4C).withOpacity(.5) ,
      appBar: AppBar(
        title: Text("Categories",style:GoogleFonts.dancingScript(fontSize: 30,color: Colors.cyan)),
        centerTitle: true,
        backgroundColor: Color(0xFF642E4C),
      ),
      body: categoryList.isNotEmpty?Container(

        child: Column(
          children: [
            Container(
              child: ListView.builder(
                shrinkWrap: true,
                  itemCount: categoryList.length,
                  itemBuilder: (context,index){
                return Container(
                  child: Text("${categoryList[index].name}"),
                );
              }),
            )
          ],
        ),
      ):CircularProgressIndicator()
    );
  }
}
