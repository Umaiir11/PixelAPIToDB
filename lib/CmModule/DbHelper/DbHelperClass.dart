import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../SchemaQuery/SchemaQuery.dart';

class DBHelper {
  Database? l_Database;
Future<Database?> FncGetDatabaseIns() async {
    if (l_Database == null) {
      await FncCreateDataBase();
    }return l_Database;
  }
  Future<void> FncCreateDataBase() async {
    final appDirectory = await getApplicationDocumentsDirectory();
    final dbDirectory = Directory('${appDirectory.path}/Database');
    await dbDirectory.create(recursive: true);
    final dbPath = path.join(dbDirectory.path, 'APPImages.db');
    final databaseExists = await databaseFactory.databaseExists(dbPath);
    if (!databaseExists) {
      l_Database = await openDatabase(
        dbPath,
        version: 1,);
      final lSchemaquery = SchemaQuery();
      await lSchemaquery.FncSchemaQuries(l_Database!);
    } else { try {
        l_Database = await openDatabase(dbPath);
        final lSchemaquery = SchemaQuery();
        await lSchemaquery.FncSchemaQuries(l_Database!);
      } catch (e) {
        //await deleteDatabase(dbPath);
        await FncCreateDataBase();
      }
    }
  }
}
