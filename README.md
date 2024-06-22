Membre du groupe \n
Mamadou Abdoul Hamid Diallo \n
Ousmane Ali Brahim
Isaac Feglar Fiacre Memini Edou
Khadiatou Diallo
Brahim Abdallahi Salem

Explications des choix architecturaux et des étapes importantes :
1. Structure en StatefulWidget : Utilisation de StatefulWidget pour permettre la mise à jour de l'interface utilisateur lorsque les données changent.
2. Controllers de texte : Utilisation de TextEditingController pour gérer la saisie de texte, facilitant l'accès aux données des champs de texte.
3. Méthode initState : Initialisation des contrôleurs de texte avec les valeurs actuelles de la tâche pour pré-remplir les champs.
4. Méthode dispose : Libération des ressources des contrôleurs de texte pour éviter les fuites de mémoire.
5. Scaffold : Utilisation de Scaffold pour la structure de base de l’écran, avec une AppBar, un body et un FloatingActionButton.
6. Méthodes pour construire des widgets : Division du code en méthodes privées (_buildHeader, _buildTextField, _buildEditButton, _buildStatusDropdown, _buildDropdownMenuItems, _buildSelectedItemWidgets) pour améliorer la lisibilité et la réutilisabilité du code.
7. setState : Utilisation de setState pour mettre à jour l'interface utilisateur lorsque l'état de la page change, comme lors de la sélection d'un nouveau statut.
8. Navigation : Utilisation de Navigator.pop pour revenir à la page précédente après la mise à jour de la tâche.
9. Insertion dans la base de données : Appel à DatabaseHelper().insertTask pour insérer une nouvelle tâche dans la base de données.
10. Mise à jour dans la base de données : Appel à DatabaseHelper().updateTask pour mettre à jour la tâche dans la base de données, suivi de l'appel du callback onUpdate pour notifier la mise à jour.
11. Pattern Singleton 
* Utilisation du pattern Singleton pour s'assurer qu'il n'y a qu'une seule instance de DatabaseHelper dans l'application.
* DatabaseHelper._internal() : Constructeur privé pour empêcher la création de nouvelles instances directement.
* factory DatabaseHelper() : Constructeur factory pour retourner l'instance unique.

Présentation de l’application 
Écran principale lorsqu’aucune tâche n’est encore ajouté 

<img width="371" alt="image" src="https://github.com/hamiddiallo/toDoAppMobile/assets/130919033/a3d8e8dd-d361-4493-b5c1-29e8cf4b21d0">

Fig : Écran d’ajout

<img width="357" alt="image" src="https://github.com/hamiddiallo/toDoAppMobile/assets/130919033/36e6de22-6638-4eed-91d0-7de8c4d30421">

Fig : Ajout de la première tache

<img width="339" alt="image" src="https://github.com/hamiddiallo/toDoAppMobile/assets/130919033/828133e7-169b-4b6a-9b68-32a80a409454">

Fig : Écran principale après l’ajout de la première tache 

<img width="361" alt="image" src="https://github.com/hamiddiallo/toDoAppMobile/assets/130919033/d9069106-71e6-4c0e-a772-95c4233eefad">

Fig : Modification de la tache une 

<img width="375" alt="image" src="https://github.com/hamiddiallo/toDoAppMobile/assets/130919033/23c1c672-f061-4fea-a38d-7826ae87f1cd">

Fig. : Écran Principale après modification de la tache  

<img width="371" alt="image" src="https://github.com/hamiddiallo/toDoAppMobile/assets/130919033/bfa20ad7-e78a-4a01-8c7f-a2c589d4e93e">

Ajoutons plusieurs autre taches

Fig : Écran Principale  

<img width="372" alt="image" src="https://github.com/hamiddiallo/toDoAppMobile/assets/130919033/229b8920-747b-4f10-beac-28fb0c071826">

Testons les filtres 
Fig : filtre des taches a faire

<img width="373" alt="image" src="https://github.com/hamiddiallo/toDoAppMobile/assets/130919033/e99c707c-a182-4118-84be-6d433afa8d51">

Fig : Liste des taches a faire 

<img width="361" alt="image" src="https://github.com/hamiddiallo/toDoAppMobile/assets/130919033/fac6d84d-05c5-4ec7-ba6c-3995c0e9a9fe">

Fig : Filtre des taches en cours et des taches déjà faites 

<img width="374" alt="image" src="https://github.com/hamiddiallo/toDoAppMobile/assets/130919033/7d0e2401-d6d4-4177-b5d1-ec349679fd1b">

Fig :Liste des taches en cours et des taches déjà faites  

<img width="380" alt="image" src="https://github.com/hamiddiallo/toDoAppMobile/assets/130919033/4a17b666-6014-459c-a9af-58027a23d2b8">

Fig : Filtre des taches avec un bug 

<img width="372" alt="image" src="https://github.com/hamiddiallo/toDoAppMobile/assets/130919033/2e1ffb49-8b05-4e81-800c-e5787cc7bf89">

Fig : Liste des taches avec un bug.  

<img width="371" alt="image" src="https://github.com/hamiddiallo/toDoAppMobile/assets/130919033/5fb80665-7a9d-4680-8f8a-124f29e38c1b">


Fig : Filtre en prenant tous les types de tache  

<img width="376" alt="image" src="https://github.com/hamiddiallo/toDoAppMobile/assets/130919033/c51da4ab-9d8d-482c-af73-6a471366f814">

Fig : Liste de Toutes Les taches 

<img width="373" alt="image" src="https://github.com/hamiddiallo/toDoAppMobile/assets/130919033/528699d1-4e84-48a3-8f67-960ea4ebe74a">

