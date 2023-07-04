import 'package:sqflite/sqflite.dart';

class SchemaQuery {
  Future<void> FncSchemaQuries(Database lDatabase) async {
    //CreateTab1
    await lDatabase.execute('''
      CREATE TABLE IF NOT EXISTS TBU_Image (
        Image TEXT,
        ISD TEXT
       )
    ''');
    await lDatabase.execute('''
      CREATE TABLE IF NOT EXISTS TBU_ApiImage (
        Image TEXT,
        ISD TEXT
       )
    ''');


    await FncCreateView(lDatabase, 'TBU_Image');
    await FncCreateView(lDatabase, 'TBU_ApiImage');
  }

  Future<void> FncCheckAndAddColumns(Database lDatabase, String lTablename, Map<String, String> lColumnstoadd) async {
    List<Map<String, dynamic>> lExistingcolumns = await lDatabase.rawQuery('PRAGMA table_info($lTablename)');
    List<String> lExistingcolumnnames = lExistingcolumns.map((column) => column['name'] as String).toList();

    List<String> lNewcolumnnames =
    lColumnstoadd.keys.where((columnName) => !lExistingcolumnnames.contains(columnName)).toList();

    for (String columnName in lNewcolumnnames) {
      String columnType = lColumnstoadd[columnName]!;
      await lDatabase.execute('ALTER TABLE $lTablename ADD COLUMN $columnName $columnType');
    }
  }

  Future<void> FncCreateView(Database lDatabase, String lTablename) async {
    await lDatabase.execute('DROP VIEW IF EXISTS   VW_$lTablename');

    await lDatabase.execute('''
      CREATE VIEW VW_$lTablename AS
      SELECT *
      FROM $lTablename Where ISD = 'false'
    ''');


  }
}
