import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_sqflite/model/todo_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLController extends GetxController{

  @override
  void onInit() {
   createdataBase();
    super.onInit();
  }

    late Database database;

  void createdataBase() async {
     // Get a location using getDatabasesPath
     var databasesPath = await getDatabasesPath();
     String path = join(databasesPath, 'todo.db');
     openAppDatabase(path: path);
     
  }

  void openAppDatabase({required String path}) async{
    // open the database
      await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
      // When creating the db, create the table
      //here todo ==>> is our table name
      // primary key is increment automatically
       await db.execute(
       'CREATE TABLE todo (id INTEGER PRIMARY KEY,'          
       'title TEXT,description TEXT,time TEXT,favorite INTEGER,'
       ' completed INTEGER)');

       debugPrint('data base is created');

     },
     onOpen: (Database db){
      database = db;
      getAllData();
      debugPrint('database is opened');
     }
    );
  }

  
  void deleteTheDatabase()async{
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'todo.db');
      await deleteDatabase(path);
      print('deleted');
  }
   
  List<TodoModel> list = [];

  void getAllData()async{
    list = [];
     var allData = await database.query('todo');
     for (var i in allData ) {
      debugPrint(i.toString());
       list.add(TodoModel.fromJson(i));
     }
    //  debugPrint(list.length.toString());
      debugPrint(allData.toString());
      update();
  }

  void insertData({
    required String title,
    required String description,
    required String time,

  }) async{
    try {
       var insert = await database.insert("todo", {
    "title": title,
    "description" : description,
    "time" :time,
    "favorite" : 0,
    "completed": 0,
   });
   Get.back();
   debugPrint("$insert data inserted");
   getAllData();
    } catch (e) {
      debugPrint(e.toString());
    }
   
  }

  bool updateTaskData = false;

  void updateData({ 
    required String title,
    required String description,
    required String time,
    required int id,
    })
     async {
    try {
      var updateData= database.update('todo', 
    {
    "title":title,
    "description" : description,
    "time" :time,
    "favorite" : 1,
    "completed": 1,
   },
   where: "id = $id"
   );

   debugPrint("updated item $updateData");
   getAllData();
   Get.back();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void deleteData({required int id}){

    var deleteItem = database.delete('todo', where: "id = $id");
    debugPrint("deleted item $deleteItem");
    getAllData();
    
  }

}