import 'dart:convert';
import 'package:e_commerce_api/screen/bottom_nav/bottom_nav.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:e_commerce_api/api_service/custom_api.dart';
import 'package:e_commerce_api/widget/const.dart';
import 'package:e_commerce_api/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({Key? key}) : super(key: key);

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    isLogin();
    super.initState();
  }

  isLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") != null) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => BottomNavPage()));
    }
  }

  getLogin() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      setState(() {
        isLoading = true;
      });
      final result =
          await CustomHttp.login(emailController.text, passwordController.text);
      setState(() {
        isLoading = false;
      });
      final data = jsonDecode(result);

      if (data["access_token"] != null) {
        setState(() {
          sharedPreferences.setString("token", data["access_token"]);
          sharedPreferences.setString("email", emailController.text);
        });
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => BottomNavPage()));
      }
      print("tttttttttttttt$data");
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: ModalProgressHUD(
          inAsyncCall: isLoading,
          blur: 2,
          opacity: .2,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF2D3C79),
                      const Color(0xFF36204B),
                      const Color(0xFF642E4C),
                      const Color(0xFF1B1A2A),
                    ],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight,
                    stops: [
                      0.1,
                      0.4,
                      0.6,
                      0.9,
                    ],
                    tileMode: TileMode.clamp,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Login Here",
                      style: myStyle(30, Colors.cyan, FontWeight.w700),
                    ),
                    CustomTextField(
                      controller: emailController,
                      hintText: "Enter Email",
                      lebelText: "Enter Your Email",
                      prefixIcon: Icon(
                        Icons.email_sharp,
                        color: Colors.cyan,
                      ),
                      //suffixIcon: Icon(Icons.email_outlined,color: Colors.white60,),
                    ),
                    CustomTextField(
                      controller: passwordController,
                      hintText: "Enter Password",
                      lebelText: "Enter Your Password",
                      prefixIcon: Icon(
                        Icons.password_sharp,
                        color: Colors.cyan,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        getLogin();
                      },
                      child: Container(
                        width: 80,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Text(
                          "Login",
                          style: myStyle(20, Colors.cyan),
                        )),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                  child: Container(
                height: MediaQuery.of(context).size.height * .30,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20))),
              )),
              Positioned(
                  left: 110,
                  top: 100,
                  child: Text(
                    "HatBazar",
                    style: GoogleFonts.dancingScript(
                        color: Colors.cyan,
                        fontWeight: FontWeight.bold,
                        fontSize: 50),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
