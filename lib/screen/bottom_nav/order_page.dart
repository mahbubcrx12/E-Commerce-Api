import 'package:jiffy/jiffy.dart';
import 'package:e_commerce_api/provider/order_provider.dart';
import 'package:e_commerce_api/widget/const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  @override
  void didChangeDependencies() async{
    Provider.of<OrderProvider>(context).getOrderData();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    var orderList=Provider.of<OrderProvider>(context).orderList;

    return SafeArea(
      child: Scaffold(
        backgroundColor:Color(0xFF642E4C).withOpacity(.5) ,
        appBar: AppBar(
          title: Text("Orders",style:GoogleFonts.dancingScript(fontSize: 30,color: Colors.cyan)),
          centerTitle: true,
          backgroundColor: Color(0xFF642E4C),
        ),
         body: orderList.isNotEmpty?Container(
           child: ListView.builder(

             shrinkWrap: true,
               itemCount: orderList.length,
               itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)
                    ),
                    height: MediaQuery.of(context).size.height*.20,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(

                            decoration: BoxDecoration(color: Colors.white70),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Name:",style: myStyle(
                                    25, Colors.black87,FontWeight.bold),),
                                Text("${orderList[index].user!.name}",style: myStyle(
                                    25, Colors.black87,FontWeight.bold),),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Price:",style: myStyle(
                                  22, Colors.black87,FontWeight.w400),),
                              Text("${orderList[index].price}tk",style: myStyle(
                                  22, Colors.black87,FontWeight.w400),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Quantity:",style: myStyle(
                                  22, Colors.black87,FontWeight.w400),),
                              Text("${orderList[index].quantity}",style: myStyle(
                                  22, Colors.black87,FontWeight.w400),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Date:",style: myStyle(
                                  22, Colors.black87,FontWeight.w400),),
                              Text(Jiffy("${orderList[index].orderDateAndTime}").yMMMMEEEEdjm,
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                );
           }),
         ):CircularProgressIndicator()
      ),
    );
  }
}
