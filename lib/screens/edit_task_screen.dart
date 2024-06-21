import 'package:flutter/material.dart';
import 'package:to_do_app/bdd/database_helper.dart';

// Définition de la page d'édition de tâche en tant que widget Stateful
class EditTaskScreen extends StatefulWidget {
  final Map<String, String> task; // La tâche à éditer
  final Function(Map<String, String>) onUpdate; // Callback pour notifier la mise à jour

  const EditTaskScreen({super.key, required this.task, required this.onUpdate});

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController _titleController; // Contrôleur de texte pour le titre
  late TextEditingController _descriptionController; // Contrôleur de texte pour la description
  late String _status; // Statut de la tâche

  @override
  void initState() {
    super.initState();
    // Initialisation des contrôleurs de texte avec les valeurs actuelles de la tâche
    _titleController = TextEditingController(text: widget.task['title']);
    _descriptionController = TextEditingController(text: widget.task['description']);
    _status = widget.task['status']!;
  }

  @override
  void dispose() {
    // Libération des ressources des contrôleurs de texte
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Définition de la barre d'application avec une couleur de fond noire
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Todo App', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
      // Corps de la page avec un padding autour des éléments
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Appel de la méthode pour construire l'en-tête
            _buildHeader(),
            const SizedBox(height: 16),
            // Appel de la méthode pour construire le champ de saisie du titre
            _buildTextField(
              controller: _titleController,
              labelText: 'Nouvelle tache',
            ),
            const SizedBox(height: 16),
            // Appel de la méthode pour construire le champ de saisie de la description
            _buildTextField(
              controller: _descriptionController,
              labelText: 'Description',
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            // Appel de la méthode pour construire le bouton de modification
            Center(
              child: _buildEditButton(),
            ),
          ],
        ),
      ),
      // Bouton flottant pour fermer la page
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: Colors.black, // Bouton de couleur noire
        child: const Icon(Icons.close, color: Colors.white), // Icône de fermeture blanche
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  // Méthode pour construire l'en-tête de la page
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Modifier',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        // Appel de la méthode pour construire le menu déroulant du statut
        _buildStatusDropdown(),
      ],
    );
  }

  // Méthode pour construire un champ de saisie
  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
      ),
    );
  }

  // Méthode pour construire le bouton de modification
  Widget _buildEditButton() {
    return ElevatedButton(
      onPressed: () async {
        if (mounted) {
          // Mise à jour de la tâche dans la base de données
          await DatabaseHelper().updateTask({
            'id': widget.task['id']!,
            'title': _titleController.text,
            'description': _descriptionController.text,
            'status': _status,
          });
          // Appel du callback onUpdate pour notifier la mise à jour
          widget.onUpdate({
            'id': widget.task['id']!,
            'title': _titleController.text,
            'description': _descriptionController.text,
            'status': _status,
          });
          // Retour à la page précédente après la mise à jour
          Navigator.pop(context, true);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black, // Couleur de fond noire
        minimumSize: const Size(150, 50),
      ),
      child: const Text(
        'Modifier',
        style: TextStyle(fontSize: 18, color: Colors.white), // Texte blanc
      ),
    );
  }

  // Méthode pour construire le menu déroulant du statut
  Widget _buildStatusDropdown() {
    return Container(
      width: 150,
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _status,
          icon: const Icon(Icons.arrow_drop_down),
          isExpanded: true,
          onChanged: (String? newValue) {
            setState(() {
              _status = newValue!;
            });
          },
          // Appel de la méthode pour construire les éléments du menu déroulant
          items: _buildDropdownMenuItems(),
          selectedItemBuilder: (BuildContext context) => _buildSelectedItemWidgets(),
        ),
      ),
    );
  }

  // Méthode pour construire les éléments du menu déroulant
  List<DropdownMenuItem<String>> _buildDropdownMenuItems() {
    const statuses = ['Todo', 'In progress', 'Done', 'Bug'];
    return statuses.map((status) {
      return DropdownMenuItem<String>(
        value: status,
        child: Row(
          children: [
            Icon(Icons.circle, color: _getStatusColor(status), size: 16),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                status,
                style: const TextStyle(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  // Méthode pour construire les widgets affichés lorsqu'un élément est sélectionné
  List<Widget> _buildSelectedItemWidgets() {
    const statuses = ['Todo', 'In progress', 'Done', 'Bug'];
    return statuses.map((status) {
      return Row(
        children: [
          Icon(Icons.circle, color: _getStatusColor(_status), size: 16),
          const SizedBox(width: 8),
          const Text(
            'Status',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      );
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
