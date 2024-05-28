import 'dart:convert';

import 'package:applicatif/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../src/data_provider/api_services.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final List<User> users = [
  ];
  List<Product> products = [];

    @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Page'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            title: Text(user.userName),
            subtitle: Text(user.email),
             shape: const RoundedRectangleBorder(
             side: BorderSide(color: Colors.black, width: 1)
              ), 
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.delete),
                  color: Colors.redAccent,
                  onPressed: () {
                    // Supprimer l'utilisateur
                    _deleteUser(context, user);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.image),
                  color: Colors.green,
                  onPressed: () {
                    // Afficher les détails de l'utilisateur
                    _showMemeUserDetails(context, user);
                  },
                ),                 
                IconButton(
                  icon: const Icon(Icons.info),
                  color: Colors.blueGrey,
                  onPressed: () {
                    // Afficher les détails de l'utilisateur
                    _showUserDetails(context, user);
                  },
                ), 
              ], 
            ), 
          );
        },
      ),
    );
  }

  void _deleteUser(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmation'),
        content: const Text('Êtes-vous sûr de vouloir supprimer cet utilisateur ?'),
        actions: [
          TextButton(
            child: const Text('Annuler'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Supprimer'),
            onPressed: () {
              // Supprimer l'utilisateur de la liste
              deleteUser(user.id);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
 
  Future<void> deleteUser(int id) async {
    final url = Uri.parse('${baseApiUrl}user/$id'); 
    final response = await http.delete(url);
  
    if (response.statusCode == 204) {
    } else {
    }
    setState(() {
    });
  }
  Future<void> fetchUsers() async {
  final url = Uri.parse('${baseApiUrl}Users'); 
  final response = await http.get(url);

  if (response.statusCode == 200) {
  // La requête s'est effectuée avec succès
  final productsJson = jsonDecode(response.body);

  // Traitez les données JSON reçues, par exemple :
 for (final productJson in productsJson) {
  final product = User.fromJson(productJson);

  // Faites ce que vous souhaitez avec les données du produit
  setState(() {
    users.add(product);
  });

  }
}
   else {
    // La requête a échoué
  }
}
  Future<void> fetchProductById(int id) async {
    final url = Uri.parse('${baseApiUrl}products/$id'); 
  final response = await http.get(url);
  if (response.statusCode == 200) {
  // La requête s'est effectuée avec succès
  final productsJson = jsonDecode(response.body);

  // Traitez les données JSON reçues, par exemple :
 for (final productJson in productsJson) {
  final product = Product.fromJson(productJson);

  // Faites ce que vous souhaitez avec les données du produit
  setState(() {
    products.add(product);
  });
  }
}
   else {
    // La requête a échoué
  }
}

    void _showMemeUserDetails(BuildContext context, User user) {
  fetchProductById(user.id);
  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Détails de l\'utilisateur'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                for(var product in products) 
                  Text('Nom: ${product.name}'), 
              ],
            ),
            actions: [
              TextButton(
                child: const Text('Fermer'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    },
  );
}
  void _showUserDetails(BuildContext context, User user) {
  bool isAdmin = false; // Variable pour stocker l'état de l'administrateur

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Détails de l\'utilisateur'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text('Admin'),
                    Switch(
                      value: isAdmin,
                      onChanged: (value) {
                        setState(() {
                          isAdmin = value;
                        });
                      },
                    ),
                  ],
                ),
                Text('Nom: ${user.userName}'),
                Text('Email: ${user.email}'),
              ],
            ),
            actions: [
              TextButton(
                child: const Text('Fermer'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    },
  );
}
}

