
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/loading-header.png'),
                const SizedBox(height: 40.0 ,),
                Center(
                    child: Container(
                      height: 50.0,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(
                                "assets/images/loading.gif",
                              ),
                              fit: BoxFit.contain,)),
                    )),
              ],
            ),
          ),
    );
  }
}
