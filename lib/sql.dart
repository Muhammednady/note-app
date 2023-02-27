import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class SQL {
  static Database? DB;

  Future<Database?> get db async {
    if (DB == null) {
      DB = await initialDB();
    }
    return DB;
  }

  Future<Database> initialDB() async {
    String initpath = await getDatabasesPath();
    String path = join(initpath, "store.db");
    Database myDB = await openDatabase(path, version: 1, onCreate: _oncreate,onUpgrade: _onUpgrade);
    return myDB;
  }

  _oncreate(Database db, int version) async {
    
    print("==========oncreate===================");

         Batch batch = db.batch();
       //  batch.execute(sql);
       //  batch.execute(sql);
    await db.execute('''
        CREATE TABLE "notes" 
        (
          'id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
          'note' TEXT NOT NULL,
          'title' TEXT NOT NULL
          
         )
         ''');
         // batch.commit();

  }

  _onUpgrade(Database db, int oldversion, int newversion) {
             db.execute('''
                 ALTER TABLE notes DELETE COLUMN color

           ''');
    print("==============onUpgrade==================");
  }

 Future<List<Map>> readData(sql) async {
    Database? mydb = await db;
    List<Map> result = await mydb!.rawQuery(sql);

    return result;
  }

 Future<int> writeData(sql) async {
    Database? mydb = await db;
    int result = await mydb!.rawInsert(sql);
    return result;
  }

 Future<int> deleteData(sql) async {
    Database? mydb = await db;
    int result = await mydb!.rawDelete(sql);

    return result;
  }

 Future<int> updateData(sql) async {
    Database? mydb = await db;
    int result = await mydb!.rawUpdate(sql);

    return result;
  }
   deleteAllNotes()async{
    Database? DB  = await db;
    DB!.delete("notes");
   // DB!.update(table, values);
   // DB!.insert(table, values);
   // DB!.query(table);
   }
 Future deleteDB()async{

   String initpath = await getDatabasesPath();
   String path = join(initpath, "store.db");
   await deleteDatabase(path);
   

  }
}
