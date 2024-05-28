
import 'dart:convert';

import 'package:applicatif/ui/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../src/data_provider/api_services.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({super.key});

  @override
  State<MyRegister> createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  Future<User>registerUser(String username, String email,String adresse, String password) async {
    final url = Uri.parse('${baseApiUrl}register'); 
    final response = await http.post(url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      'id' : 0,
      'userName': username,
      'email':email,
      'adresse': adresse,
      'password' : password,
      'role' : 0
    }),
    
  );
  if (response.statusCode == 201) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create post');
  }
  }
  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController addresseController = TextEditingController();

  TextEditingController emailController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
         padding: const EdgeInsets.all(40),
         child: ListView(
          children: <Widget>[
             Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Register',
                  style: TextStyle(fontSize: 20),
                )),
              Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'username',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: addresseController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'addresse',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'password',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'confirm password',
                ),
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Submit'),
                  onPressed: () {
                    registerUser(nameController.text,emailController.text, addresseController.text, passwordController.text);

                    Navigator.of(context).push(
                  MaterialPageRoute(
                     builder: (context) {
                       return  const MyLoginPage();
                     }
                  ),
                );
                  },
                )
            ),
            
          ],
         )
      )
    );
  }
}