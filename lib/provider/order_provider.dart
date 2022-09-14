import 'package:e_commerce_api/api_service/custom_api.dart';
import 'package:e_commerce_api/model/order_model.dart';
import 'package:flutter/material.dart';
class OrderProvider with ChangeNotifier{
List<OrderModel>orderList=[];

getOrderData()async{
  orderList=await CustomHttp().fetchOrder();
  notifyListeners();
}
}