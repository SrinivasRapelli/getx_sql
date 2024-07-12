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
     var allData = await database.query('todo');
     for (var i in allData ) {
      debugPrint(i.toString());
       list.add(TodoModel.fromJson(i));
     }
    //  debugPrint(list.length.toString());
      debugPrint(allData.toString());
      update();
  }

  void insertData() async{
    var insert = await database.insert("todo", {
    "title":"go",
    "description" : "go to school",
    "time" :"10",
    "favorite" : 0,
    "completed": 0,
   });
   debugPrint("$insert data inserted");
   getAllData();
  }

  void updateData(){
    var updateData= database.update('todo', {
    "title":"play",
    "description" : "go play foodball",
    "time" :"12",
    "favorite" : 1,
    "completed": 1,
   },
   where: "id = ${1}"
   );

   debugPrint("updated item $updateData");
   getAllData();
  }

  void deleteData(){

    var deleteItem = database.delete('todo', where: "id = ${2}");
    debugPrint("deleted item $deleteItem");
    getAllData();
    
  }

}