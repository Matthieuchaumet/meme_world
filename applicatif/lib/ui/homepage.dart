import 'package:applicatif/ui/login.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
  
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('This is the home page fdp'),
            const SizedBox(height: 20), // Espacement entre le texte et le bouton
            ElevatedButton(
              onPressed: () {
                 Navigator.of(context).push(
                  MaterialPageRoute(
                     builder: (context) {
                       return  const MyLoginPage();
                     }
                  ),
                );
              },
              child: const Text('Connection'),
            ),
          ],
        ),
      );
  }
}
