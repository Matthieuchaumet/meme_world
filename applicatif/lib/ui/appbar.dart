import 'package:applicatif/src/bloc/auth_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../src/bloc/auth_bloc.dart';
import '../src/bloc/auth_state.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});
  @override
  
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  

  @override
  Widget build(BuildContext context) {
    final logout = BlocBuilder<AuthBloc, AuthState>( builder : (context ,state) {
      if (state is UserLoginSuccessState || state is AdminLoginSuccessState ) {
        return IconButton(
          tooltip: 'logout',
          onPressed: () {
            BlocProvider.of<AuthBloc>(context).add(LogoutButtonPressed());
             ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('user deconnected with sucess')));

          } , 
        icon: const Icon(Icons.logout));
      } else { 
        return Container();
      }
    });
    final char = BlocBuilder<AuthBloc, AuthState>( builder : (context ,state) {
      if (state is LogoutLoaddingState ) {
        return const CircularProgressIndicator();
      } else {
        return Container();
      }
    },
    );
    return AppBar(
      backgroundColor: Colors.lightBlueAccent,
      title: const Text('SUATake my money'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          tooltip: 'CartPage',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('This is the future page of the meme download')));
          },
        ),logout,
        char    
      ],
    );
  }
}
