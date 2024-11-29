import 'package:choppi_prueba_tecnica/bloc/login_bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/group-characters.png',
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height,
            ),
            Container(
              color: Colors.black.withOpacity(0.95),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/loading-header.png'),
                const SizedBox(
                  height: 50.0,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        backgroundColor: Colors.lightGreen,
                        shadowColor: Colors.lightGreen,
                        elevation: 6),
                    onPressed: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      loginBloc.add(SignInEvent());
                    },
                    child: const Text('Ingresar', style: TextStyle(color: Colors.white),))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
