import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Classe pour gérer la base de données SQLite
class DatabaseHelper {
  // Singleton : instance unique de DatabaseHelper
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  // Factory constructor pour retourner l'instance unique
  factory DatabaseHelper() {
    return _instance;
  }

  // Constructeur interne privé
  DatabaseHelper._internal();

  // Getter pour obtenir la base de données
  Future<Database> get database async {
    // Si la base de données existe déjà, la retourner
    if (_database != null) return _database!;
    // Sinon, initialiser la base de données
    _database = await _initDatabase();
    return _database!;
  }

  // Méthode pour initialiser la base de données
  Future<Database> _initDatabase() async {
    // Obtenir le chemin du dossier des bases de données et y ajouter le nom du fichier
    String path = join(await getDatabasesPath(), 'tache.db');
    // Ouvrir la base de données et exécuter la méthode _onCreate si nécessaire
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Méthode de création de la table tasks
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        status TEXT
      )
    ''');
  }

  // Méthode pour insérer une tâche dans la table tasks
  Future<int> insertTask(Map<String, String> task) async {
    Database db = await database;
    return await db.insert('tasks', task);
  }

  // Méthode pour mettre à jour une tâche existante dans la table tasks
  Future<int> updateTask(Map<String, String> task) async {
    Database db = await database;
    int id = int.parse(task['id']!);
    return await db.update(
      'tasks',
      task,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Méthode pour supprimer une tâche de la table tasks
  Future<int> deleteTask(int id) async {
    Database db = await database;
    return await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Méthode pour obtenir toutes les tâches de la table tasks
  Future<List<Map<String, dynamic>>> getTasks() async {
    Database db = await database;
    return await db.query('tasks');
  }
}
