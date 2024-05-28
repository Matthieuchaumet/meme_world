import 'package:applicatif/src/bloc/auth_bloc.dart';
import 'package:applicatif/src/bloc/auth_events.dart';
import 'package:applicatif/src/repository/auth_repo.dart';
import 'package:applicatif/ui/admin.dart';
import 'package:applicatif/ui/appbar.dart';
import 'package:applicatif/ui/homepage.dart';
import 'package:applicatif/ui/login.dart';
import 'package:applicatif/ui/navbotbar.dart';
import 'package:applicatif/ui/products.dart';
import 'package:applicatif/ui/profil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final int _selectedIndex = 0;

  final List<Widget> _pages = const [
     HomePage(),
     ProductPage(),
     Placeholder(),
     Profil(),
     AdminPage()
  ];


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(AuthRepository())
        ..add( StartEvent()), // utilisation de cascade pour pouvoir être considérer connecté ou non lors du lancement de l'appli
      child: MaterialApp(
        routes: {
          '/login': (context) => const MyLoginPage(),
        },
        title: 'SHUAtakemymoney',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        ),
        home: MyContent(pages: _pages, selectedIndex: _selectedIndex),
      ),
    );
  }
}


class MyAppState extends ChangeNotifier {
}


// ignore: must_be_immutable
class MyContent extends StatefulWidget {
  final List<Widget> pages;
  int selectedIndex;
  

   MyContent({Key? key, required this.pages, required this.selectedIndex}) : super(key: key);

  @override
  State<MyContent> createState() => _MyContentState();
}

class _MyContentState extends State<MyContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: widget.pages[widget.selectedIndex],
      bottomNavigationBar: BotNavBar(
        selectedIndex: widget.selectedIndex,
        onItemTapped: (index) {
          setState(() {
            widget.selectedIndex = index;
          });
        },
      ),
    );
  }
}

