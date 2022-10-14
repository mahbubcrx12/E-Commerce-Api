import 'package:e_commerce_api/provider/category_provider.dart';
import 'package:e_commerce_api/screen/add_category_page.dart';
import 'package:e_commerce_api/screen/edit_category_page.dart';
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
  void didChangeDependencies() async {
    Provider.of<CategoryProvider>(context).getCategoryData();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var categoryList = Provider.of<CategoryProvider>(context).categoryList;

    return Scaffold(
      backgroundColor: Color(0xFF642E4C).withOpacity(.5),
      appBar: AppBar(
        title: Text("Categories",
            style: GoogleFonts.dancingScript(fontSize: 30, color: Colors.cyan)),
        centerTitle: true,
        backgroundColor: Color(0xFF642E4C),
      ),
      body: categoryList.isNotEmpty
          ? Container(
              child: Container(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemCount: categoryList.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      addRepaintBoundaries: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * .40,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Image(
                                    image: NetworkImage(
                                        "https://apihomechef.antopolis.xyz/images/${categoryList[index].image ?? ""}"),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                                Text("ID: ${categoryList[index].id}"),
                                Text("Category: ${categoryList[index].name}"),
                                Expanded(
                                  flex: 2,
                                  child: Image(
                                    image: NetworkImage(
                                      "https://apihomechef.antopolis.xyz/images/${categoryList[index].icon ?? ""}",
                                    ),

                                    fit: BoxFit.cover,
                                    // height: 10,
                                    width: double.infinity,
                                  ),
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (_) => EditCategoryPage(categoryModel: categoryList[index],)));
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            color: Colors.redAccent,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Center(
                                            child: Text(
                                          "Edit",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      })),
            )
          : CircularProgressIndicator(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddCategoryPage()))
              .then((value) =>
                  Provider.of<CategoryProvider>(context, listen: false)
                      .getCategoryData());
        },
        backgroundColor: Color(0xFF642E4C),
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
