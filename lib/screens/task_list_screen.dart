import 'package:flutter/material.dart';
import 'package:to_do_app/bdd/database_helper.dart';
import 'package:to_do_app/widget/task_filter.dart';
import 'package:to_do_app/screens/add_task_screen.dart';
import 'package:to_do_app/screens/edit_task_screen.dart';

// Définition de la page d'accueil en tant que widget Stateful
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> tasks = []; // Liste des tâches
  Map<String, bool> filters = {
    'Todo': true,
    'In progress': true,
    'Done': true,
    'Bug': true,
  };

  @override
  void initState() {
    super.initState();
    _loadTasks(); // Chargement des tâches lors de l'initialisation
  }

  // Méthode pour charger les tâches depuis la base de données
  Future<void> _loadTasks() async {
    final dbTasks = await DatabaseHelper().getTasks();
    setState(() {
      tasks = dbTasks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(), // Construction de la barre d'application
      body: _buildTaskList(), // Construction de la liste des tâches
      floatingActionButton: _buildFloatingActionButton(), // Construction du bouton flottant
    );
  }

  // Méthode pour construire la barre d'application
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      title: const Text(
        'Todo App',
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.filter_alt, color: Colors.white),
          onPressed: () {
            _showFilterDialog(); // Affichage du dialogue de filtre
          },
        ),
      ],
    );
  }

  // Méthode pour afficher le dialogue de filtre
  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => TaskFilter(
        initialFilters: filters,
        onFilterChanged: (newFilters) {
          setState(() {
            filters = newFilters; // Mise à jour des filtres
          });
        },
      ),
    );
  }

  // Méthode pour construire le bouton flottant
  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddTaskScreen()),
        );
        if (result == true) {
          _loadTasks(); // Recharge les tâches après ajout
        }
      },
      backgroundColor: Colors.black,
      child: const Icon(Icons.add, color: Colors.white),
    );
  }

  // Méthode pour construire la liste des tâches
  Widget _buildTaskList() {
    if (tasks.isEmpty) {
      return const Center(child: Text("Cliquez sur le bouton (+) pour ajouter une tâche"));
    }
    final filteredTasks = _filteredTasks(); // Application des filtres
    return ListView.builder(
      itemCount: filteredTasks.length,
      itemBuilder: (context, index) {
        final task = filteredTasks[index];
        return _buildTaskItem(task, index); // Construction de chaque tâche
      },
    );
  }

  // Méthode pour construire un élément de tâche
  Widget _buildTaskItem(Map<String, dynamic> task, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: _getStatusColor(task['status'])),
        borderRadius: BorderRadius.circular(5),
      ),
      child: ListTile(
        leading: Icon(Icons.circle, color: _getStatusColor(task['status'])),
        title: Text(
          task['title'],
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () async {
          await _editTask(task, index); // Édition de la tâche au clic
        },
      ),
    );
  }

  // Méthode pour éditer une tâche
  Future<void> _editTask(Map<String, dynamic> task, int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTaskScreen(
          task: {
            'id': task['id'].toString(),
            'title': task['title'],
            'description': task['description'],
            'status': task['status'],
          },
          onUpdate: (updatedTask) {
            setState(() {
              tasks = List.from(tasks)
                ..removeAt(index)
                ..insert(index, updatedTask); // Mise à jour de la tâche dans la liste
            });
          },
        ),
      ),
    );
    if (result == true) {
      _loadTasks(); // Recharge les tâches après édition
    }
  }

  // Méthode pour filtrer les tâches
  List<Map<String, dynamic>> _filteredTasks() {
    return tasks.where((task) {
      return filters[task['status']]!;
    }).toList();
  }

  // Méthode pour obtenir la couleur associée à chaque statut
  Color _getStatusColor(String status) {
    switch (status) {
      case 'In progress':
        return Colors.blue;
      case 'Done':
        return Colors.green;
      case 'Bug':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
