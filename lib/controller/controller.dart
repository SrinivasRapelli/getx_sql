import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLController extends GetxController{

  @override
  void onInit() {
   createdataBase();
    super.onInit();
  }

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
       await db.execute(
       'CREATE TABLE todo (id INTEGER PRIMARY KEY,' 
       'title TEXT,description TEXT,time favorite INTEGER,'
       ' completed INTEGER)');

       debugPrint('data base is created');

     },
     onOpen: (Database database){
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
   
  
  void getAllData(){

  }

  void insertData(){

  }

  void updateData(){

  }

  void deleteData(){
    
  }

}