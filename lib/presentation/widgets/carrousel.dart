import 'package:cached_network_image/cached_network_image.dart';
import 'package:choppi_prueba_tecnica/model/character.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CharactersCarrousel extends StatelessWidget {
  const CharactersCarrousel({Key? key, required this.characters})
      : super(key: key);

  final List<Result>? characters;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270.0,
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Personajes',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                TextButton(
                  style: TextButton.styleFrom(shape: const StadiumBorder()),
                  onPressed: () {
                    context.goNamed('characters', );
                  },
                  child: Text('Ver todos'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: characters!.length,
                itemBuilder: (context, index) {
                  final character = characters![index];
                  return Card(
                    color: Color(0xFF114d40).withOpacity(0.9),
                    shadowColor: Color(0xFF114d40).withOpacity(0.6),
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: CachedNetworkImage(
                            height: 270.0,
                            width: 150.0,
                            fit: BoxFit.cover,
                            imageUrl: character.image!,
                          ),
                        ),
                        Positioned(
                          bottom: 0.0,
                          width: 150.0,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            height: 70.0,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                  Colors.black,
                                  Colors.black87,
                                  Colors.black54,
                                  Colors.transparent
                                ])),
                            child: Column(
                              children: [
                                Text(
                                  character.name!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18.0),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
