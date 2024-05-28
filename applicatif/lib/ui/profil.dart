import 'dart:convert';
import 'package:applicatif/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';
import '../src/data_provider/api_services.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});
  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  User me = User(id: 0,userName: '', adresse: '', role: 0, email: '',imagePath: '', password: '');
  List<Product> products = [];
  TextEditingController usernameController = TextEditingController();
  TextEditingController adresseController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  initState()  {

    getCurrentUser();
    super.initState();
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
     } else {
    // La requête a échoué
  }
}
Future<void> getCurrentMeme(User user) async {
  fetchProductById(user.id);
}
Future<void> getCurrentUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  final url = Uri.parse('${baseApiUrl}me'); 
  final response = await http.get(url,headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      'Authorization' : 'bearer $token'},);
  if (response.statusCode == 200) {
    final userJson = jsonDecode(response.body);

    final user = User.fromJson(userJson);
    setState(() {
    me = user;
  }
  );
  getCurrentMeme(me);
  }
}
Future<void> editUser(User user, String username, String email, String adresse ) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  final url = Uri.parse('${baseApiUrl}user/${user.id}'); 
  final response = await http.put(url,headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      'Authorization' : 'bearer $token'},
      body: jsonEncode({ 
        "id" : user.id,      
        "userName" : username,
        "email" : email,
        "adresse" : adresse,
        "password" : user.password,
        "role" :  user.role
        }),
  );
  if (response.statusCode == 204) {
        setState(() {
          
        });
} else {
       throw Exception('Failed to create post');
       
}
}
  @override

Widget build(BuildContext context) {
  return DefaultTabController(
    length: 2,
    child: SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            Stack(
              children: [
                const CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.cyan,
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: InkWell(
                    onTap: () {
                      _showBottomSheetUserEdit( context);
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Text(
              'Here your profil page Bro',
              style: TextStyle(
                fontFamily: 'SourceSansPro',
                fontSize: 25,
              ),
            ),
            Text(
              'Welcome Stranger',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'SourceSansPro',
                color: Colors.red[400],
                letterSpacing: 2.5,
              ),
            ),
            SizedBox(
              height: 20.0,
              width: 200,
              child: Divider(
                color: Colors.teal[100],
              ),
            ),
            const TabBar(
              tabs: [
                Tab(text: 'My Profil'),
                Tab(text: 'My Memes'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [               
                     Column(
                      children: [
                        Card(
                          color: Colors.white,
                          margin: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 25.0,
                          ),
                          child: ListTile(
                            leading: Icon(
                              Icons.person_4,
                              color: Colors.teal[900],
                            ),
                            title: Text(
                              me.userName,
                              style: const TextStyle(
                                fontFamily: 'BalooBhai',
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                        Card(
                          color: Colors.white,
                          margin: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 25.0,
                          ),
                          child: ListTile(
                            leading: Icon(
                              Icons.home_work,
                              color: Colors.teal[900],
                            ),
                            title: Text(
                              me.adresse,
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'Neucha',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  
                  // Contenu de l'onglet "Mes Produits"
                  SingleChildScrollView(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  <Widget>[
                          for (var product in products)
                            UserMeme(product.name, product.price,product.id)
                        ],
                      ),
                    ),
                  )
                  
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
void _showBottomSheetUserEdit(BuildContext context) {

  
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder( builder: (context, setState) => 
         SizedBox(
          height: 600,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.cyan,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Action à effectuer lorsque le bouton est cliqué
                          },
                          child: const Text('Change fdp'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
                child:  TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
                child:  TextField(
                  controller: adresseController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Adresse',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
                child:  TextField(
                  controller : emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
              ),
              const SizedBox(
                height:20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      editUser(me, usernameController.text, emailController.text, adresseController.text);
                    },
                    child: const Text('Edit'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
}
 class UserMeme extends StatefulWidget {
  final  String name;
  final  int price;
  final  int id;
  const UserMeme( this.name,  this.price,this.id, {super.key});

  @override
  State<UserMeme> createState() => _UserMemeState();
}

class _UserMemeState extends State<UserMeme> {
  @override
   Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
             Text(widget.name),
             Text('${widget.price}'),
             TextButton(onPressed:() {
              _deleteMeme(context,widget.id);
             },
             child: const Text('delete')
             ),
             SizedBox(height: 20.0,
                      width: 100,
                      child: Divider(
                        color: Colors.amber[200],
                      ),

             )
        ],
      ),
    );
   }

   void _deleteMeme(BuildContext context,int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmation'),
        content: const Text('Êtes-vous sûr de vouloir supprimer ce Meme ?'),
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
              deleteMemeById(id);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Future<void>deleteMemeById(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var  token = prefs.getString('token');
    final url = Uri.parse('${baseApiUrl}product/$id'); 
    final response = await http.delete(url,
     headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      'Authorization' : 'bearer $token'} );
    if (response.statusCode == 204) {
      setState(() {
        
      });
    } else {
    }
  }
}
