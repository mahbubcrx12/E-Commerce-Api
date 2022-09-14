import 'dart:convert';
import 'package:e_commerce_api/model/category_model.dart';
import 'package:e_commerce_api/model/order_model.dart';
import 'package:e_commerce_api/widget/const.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CustomHttp{
  static const Map<String,String> defaultHeader={
    "Accept":"application/json",
  };
  static Future<String> login(String email,String password) async{
   try{
     var link='${baseUrl}api/admin/sign-in';
     var map=Map<String,dynamic>();
     map["email"]=email;
     map["password"]=password;
     final response=await http.post(
       Uri.parse(link),
       body:map,
       headers: defaultHeader,
     );
     if(response.statusCode==200){

       return response.body;
     }else{
       return "something else";
     }
   }catch(e){
     return "Something else";
   }

  }

static Future<Map<String,String>> getHeadersWithToken()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var header={
      "Accept":"application/json",
      "Authorization":"bearer ${sharedPreferences.getString("token")}"
    };
    print("ttttttttttttt is ${sharedPreferences.getString("token")}");
    return header;
}

  Future<List<OrderModel>> fetchOrder()async{
    List<OrderModel> orderList=[];
    try{
      var link="${baseUrl}api/admin/all/orders";
      var response=await http.get(Uri.parse(link),
          headers: await getHeadersWithToken());
      if(response.statusCode==200){
        var data=jsonDecode(response.body);

        OrderModel orderModel;
        for(var i in data){
          orderModel=OrderModel.fromJson(i);
          orderList.add(orderModel);
        }
        print("Order data ${data}");
        return orderList;
      }else{
        return orderList;
      }

    }catch(e){
      print("Errrrrrr $e");
      return orderList;
    }
  }

  Future<List<CategoryModel>> fetchCategory()async{
   List<CategoryModel> categoryList=[];
    try{
      var link="${baseUrl}api/admin/category";
      var response=await http.get(Uri.parse(link),
          headers: await getHeadersWithToken());
      if(response.statusCode==200){
        var data=jsonDecode(response.body);

        CategoryModel categoryModel;
        for(var i in data){
          categoryModel=CategoryModel.fromJson(i);
          categoryList.add(categoryModel);
        }
        print("Category data cccccccccccccccccccccccccccccc ${data}");
        return categoryList;
      }else{
       return categoryList;
      }

    }catch(e){
      print("Errrrrrr $e");
     return categoryList;
    }
  }
}