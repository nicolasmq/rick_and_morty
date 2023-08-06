import 'package:animate_do/animate_do.dart';
import 'package:choppi_prueba_tecnica/model/episode.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EpisodesCarrousel extends StatelessWidget {
  const EpisodesCarrousel({Key? key, required this.episodes}) : super(key: key);

  final List<EpisodeData>? episodes;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                  'Episodios',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                TextButton(
                  style: TextButton.styleFrom(shape: const StadiumBorder()),
                  onPressed: () {
                    context.goNamed('episodes');
                  },
                  child: const Text('Ver todos'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: episodes!.length,
                itemBuilder: (context, index) {
                  final episode = episodes![index];
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        barrierLabel: 'No information',
                        barrierDismissible: true,
                        context: context,
                        builder: (context) => SlideInUp(
                          from: 20.0,
                          child: Dialog(
                            backgroundColor: Colors.transparent,
                            surfaceTintColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 15.0),
                                  height: size.height * 0.3,
                                  width: size.width * 0.8,
                                  decoration: BoxDecoration(
                                    color: Colors.black87,
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/error-img.png',
                                        height: 150.0,
                                      ),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      const Text(
                                        'Al parecer algo salió mal',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 18.0),
                                      ),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                    bottom: -15.0,
                                    left: 0.0,
                                    right: 0.0,
                                    child: FloatingActionButton(
                                      backgroundColor: Colors.white60,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Icon(Icons.close),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.black.withOpacity(0.6),
                      shadowColor: const Color(0xFF114d40).withOpacity(0.6),
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.asset(
                              coverImage(context, episode.episode!),
                              height: 270.0,
                              width: 150.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 0.0,
                            width: 150.0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              height: 100.0,
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    episode.name!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18.0),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  String coverImage(BuildContext contex, String episodeName) {
    if (episodeName.startsWith('S01')) {
      return 'assets/images/cover-s1.png';
    } else if (episodeName.startsWith('S02')) {
      return 'assets/images/cover-s2.png';
    } else if (episodeName.startsWith('S03')) {
      return 'assets/images/cover-s3.png';
    } else if (episodeName.startsWith('S04')) {
      return 'assets/images/cover-s4.png';
    } else {
      return 'assets/images/cover-s5.png';
    }
  }
}
