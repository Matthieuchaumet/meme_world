import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../src/bloc/auth_bloc.dart';
import '../src/bloc/auth_state.dart';

class BotNavBar extends StatefulWidget {
  final int selectedIndex;
  final void Function(int) onItemTapped;

  const BotNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  State<BotNavBar> createState() => _BotNavBarState();
}

class _BotNavBarState extends State<BotNavBar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>( builder : (context ,state) {
      if(state is AdminLoginSuccessState)  {
      return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 24),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image, size: 24),
            label: 'Meme',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, size: 24),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 24),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.admin_panel_settings, size: 24),
            label: 'Admin',
          ),
        ],
        currentIndex: widget.selectedIndex,
        onTap: widget.onItemTapped,
      );} else { return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 24),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image, size: 24),
            label: 'Meme',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, size: 24),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 24),
            label: 'Profil',
          )
        ],
        currentIndex: widget.selectedIndex,
        onTap: widget.onItemTapped,
      );   
      }
    }
  );
  }
}
