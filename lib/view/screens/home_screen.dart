import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_sqflite/controller/controller.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key, required this.title});
   final String title;
  final controller = Get.put(SQLController());
  

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){
              controller.deleteTheDatabase();
            }, 
            icon: const  Icon(
              Icons.remove
              ),
              ),
        
         IconButton(
            onPressed: (){
              controller.insertData();
            }, 
            icon: const  Icon(
              Icons.add
              ),),
        ],
      ),
      body: Column(
        children: [
          IconButton(
            onPressed: (){
               controller.updateData();
            },
            icon: 
            const Icon(Icons.share)),
             IconButton(
            onPressed: (){
               controller.deleteData();
            },
            icon: 
            const Icon(Icons.delete)),


        ],
        ),
    );
  }
}