import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';
import '../src/data_provider/api_services.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
   List<Product> products = [];
   TextEditingController nameController = TextEditingController();
   TextEditingController priceController = TextEditingController();
  @override
  void initState() {
    super.initState();
    fetchProducts();
  }
  Future<void> fetchProducts() async {
  final url = Uri.parse('${baseApiUrl}Products'); 
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
  void _createMeme(BuildContext context) {
showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Create a meme '),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [              
                 Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'name',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: priceController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'price',
                  ),
                ),
              ),
              ],
            ),
            actions: [
              TextButton(
                child: const Text('Create'),
                onPressed: () {
                  create(nameController.text, int.parse(priceController.text));
                  Navigator.of(context).pop();
                },
              ),
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
  Future<Product> create(String name, int price) async {
    final url = Uri.parse("${baseApiUrl}product/create");
    SharedPreferences pref = await SharedPreferences.getInstance();
    final userId = pref.getInt("id");
    String? token = pref.getString('token');
    final body = {
      "name": name,
      "price": price,
      "userId" : userId
    };
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      'Authorization' : 'bearer $token'
    };

    final response = await http.post(url, headers: headers, body: json.encode(body));
    if (response.statusCode == 201) {
      return Product.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create post');
    }
  }
   @override
     Widget build(BuildContext context) {
  return Scaffold(
    body:  Center(
      child: ListView(
        children: [
            for (var product in products)
             ProductCard(
              //imagePath: 'assets/images/product1.jpg',
              name: product.name,
              price: product.price,
            ),
        ],
      ), 
    ),
    floatingActionButton: FloatingActionButton(
        tooltip: 'Create Meme',
        onPressed: () {
          _createMeme(context);
          setState(() {
          });
        },
        backgroundColor: Colors.greenAccent,
        child: const Icon(Icons.add),
      ),

  );
  }
}



class ProductCard extends StatelessWidget {
  //final String imagePath;
  final String name;
  final int price;

  const ProductCard({super.key, 
    //required this.imagePath,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            flex: 1,
            child:  Placeholder(),
            //child: Image.asset(
            //  imagePath,
            //  fit: BoxFit.cover,
            //),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '\$$price',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Ajout au panier
                      },
                      child: const Text('Add to cart'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Afficher les détails
                      },
                      child: const Text('Details'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

