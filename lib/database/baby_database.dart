import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';

import '../models/baby.dart';

Future<Database> _openBabyDatabase() async {
  // Get a location using path_provider
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  await appDocumentDirectory.create(recursive: true);
  final dbPath = appDocumentDirectory.path;

  return await databaseFactoryIo.openDatabase(join(dbPath, 'baby_database.db'));
}

final _store = intMapStoreFactory.store('baby_store');

Future<int> addBaby(Baby baby) async {
  final db = await _openBabyDatabase();
  return await _store.add(db, baby.toMap());
}

Future<List<Baby>> getAllBabies() async {
  final db = await _openBabyDatabase();
  final recordSnapshots = await _store.find(db);

  return recordSnapshots.map((snapshot) {
    var baby = Baby.fromMap(snapshot.key, snapshot.value);
    return baby;
  }).toList();
}

Future<void> updateBaby(int? id, Baby updatedBaby) async {
  final db = await _openBabyDatabase();
  final filter = Filter.byKey(id);
  final foundBaby = await _store.findFirst(db, finder: Finder(filter: filter));

  if (foundBaby == null) {
    throw ArgumentError('Baby with id $id not found');
  }

  await _store.update(db, updatedBaby.toMap(), finder: Finder(filter: filter));
}

Future<void> deleteBaby(int id) async {
  final db = await _openBabyDatabase();
  final filter = Filter.byKey(id);
  await _store.delete(db, finder: Finder(filter: filter));
}
