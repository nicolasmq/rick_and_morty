import 'package:flutter/material.dart';

class RickAndMortyLayout extends StatelessWidget {
  const RickAndMortyLayout({Key? key, required this.child, this.appBarExtension}) : super(key: key);

  final Widget child;
  final Widget? appBarExtension;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/group-characters.png',
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height,
        ),
        Container(
          color: Colors.black.withOpacity(0.95),
        ),
        child,
        appBarExtension ?? Container()
      ],
    );
  }
}
