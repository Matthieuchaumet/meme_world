
import 'package:applicatif/src/bloc/auth_bloc.dart';
import 'package:applicatif/src/bloc/auth_state.dart';
import 'package:applicatif/ui/admin.dart';
import 'package:applicatif/ui/homepage.dart';
import 'package:applicatif/ui/products.dart';
import 'package:applicatif/ui/profil.dart';
import 'package:applicatif/ui/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:applicatif/src/bloc/auth_events.dart';

import '../main.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({Key? key}) : super(key: key);
 
  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}
 
class _MyLoginPageState extends State<MyLoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
  late AuthBloc authBloc;
@override
void initState() {

  authBloc = BlocProvider.of<AuthBloc>(context);

  super.initState();
}



  @override
  Widget build(BuildContext context) {
    final msg = BlocBuilder<AuthBloc, AuthState>( builder : (context ,state) {
      if (state is LoginErrorState) {
        return Text(state.message,
                    style: const TextStyle(color: Colors.redAccent) );
      } else if(state is LoginLoadingState) {
        return const Center(child : CircularProgressIndicator(),);
      } else { 
        return Container();
      }
    },
    );
    return Scaffold(
 body: BlocListener<AuthBloc, AuthState>(
    listener: (context, state) {
      if (state is UserLoginSuccessState || state is AdminLoginSuccessState) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MyContent(
              pages: const  [
                 HomePage(),
                 ProductPage(),
                 Placeholder(),
                 Profil(),
                 AdminPage()
              ],
              selectedIndex: 1,
            ),
          ),
          (route) => false,
        );
      }
    },child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
                          Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'SUATake MM',
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
                  msg,
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  //forgot password screen
                },
                child: const Text('Forgot Password',),
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Login'),
                    onPressed: () {                      
                      authBloc.add(LoginButtonPressed(username :usernameController.text, password : passwordController.text));

                    },
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Does not have account?'),
                  TextButton(
                    child: const Text(
                      'Sign up',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return   const MyRegister();
                        }
                      ),
                  );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}