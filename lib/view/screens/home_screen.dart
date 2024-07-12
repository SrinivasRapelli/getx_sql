import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_sqflite/controller/controller.dart';
import 'package:getx_sqflite/view/screens/edit_screen.dart';
import 'package:getx_sqflite/view/widgets/todo_item.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key, required this.title});
  final String title;
 // final control = Get.put(SQLController());
  final  SQLController control = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     onPressed: (){
        //       controller.deleteTheDatabase();
        //     }, 
        //     icon: const  Icon(
        //       Icons.remove
        //       ),
        //   ),
        //   IconButton(
        //     onPressed: (){
        //       controller.insertData();
        //     }, 
        //     icon: const  Icon(
        //       Icons.add
        //       ),
        //   ),
        // ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Get.to(()=> EditScreen(), transition: Transition.downToUp);
       // Navigator.push(context, MaterialPageRoute(builder: (context) => EditScreen()));
      },
       child: const Icon(Icons.add),
      ),
      body: GetBuilder<SQLController>(
        builder: (controller) => ListView.builder(
          itemCount: controller.list.length,
          itemBuilder: (context, index) => TodoItem(controller: controller, index: index)),
      ),
    );
  }
}
