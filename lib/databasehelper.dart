import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:money_management/modelexp.dart';


import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

String usertable="x";

String id="id";
class DataBaseHelper1{
  static final DataBaseHelper1 _instance=new DataBaseHelper1.internal();
  factory DataBaseHelper1() {
    return _instance;
  }
  static Database _db;
  Future<Database> get db async{
    if(_db!=null){
      return _db;
    }
    _db = await initializedatabse();
    return _db;

  }


  DataBaseHelper1.internal();
//initializing the database
  initializedatabse()async {
    Directory directory= await getApplicationDocumentsDirectory();
    String path=join(directory.path,"new.db");
    var ourdb=openDatabase(path,version: 1,onCreate: _onCreate);
    return ourdb;
  }


//creating a table
  void _onCreate(Database db, int version)async  {
    await db.execute(
        "CREATE TABLE $usertable($id INTEGER PRIMARY KEY,cost INTEGER,exp TEXT,state INTEGER)"
    );
  }

  Future<int> saveuser(expense provider)async{
    var dbclient=await db;
    int res=await dbclient.insert(usertable, provider.toMap());
    return res;


  }

  Future<List> getallusers()async{
    var dbclient=await db;

    var res=await dbclient.rawQuery("SELECT * FROM $usertable");
    return res.toList();

  }
  Future<int> getcount()async {
    var dbclient=await db;
    return Sqflite.firstIntValue(
        await dbclient.rawQuery("SELECT COUNT(*) FROM $usertable")
    );

  }

  Future<expense> getUser(String service)async{
    var dbclient=await db;
    var res=await dbclient.query("$usertable", where: "exp = ?", whereArgs: [service]);
    print(res.isEmpty);
    if(res.isNotEmpty){
      return expense.fromMap(res.first);

    }
    else{
      Fluttertoast.showToast(
          msg: "Service not found(enter valid service name)",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }


  }
  Future<int> deleteUser(int id1)async{
    var dbclient =await db;
    return dbclient.delete(usertable,where: "$id=?",whereArgs: [id1]);

  }
  





}