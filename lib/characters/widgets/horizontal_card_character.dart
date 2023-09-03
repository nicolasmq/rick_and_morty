import 'package:cached_network_image/cached_network_image.dart';
import 'package:choppi_prueba_tecnica/characters/models/models.dart';
import 'package:flutter/material.dart';

class HorizontalCardCharacter extends StatelessWidget {
  const HorizontalCardCharacter({Key? key, required this.characterData, this.onTap})
      : super(key: key);

  final CharacterData characterData;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: 200.0,
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8), borderRadius: BorderRadius.circular(20.0)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0)),
              child: CachedNetworkImage(
                imageUrl: characterData.image ?? '',
                width: 50.0,
                height: 50.0,
                progressIndicatorBuilder: (context, url, progress) =>
                    const SizedBox(
                        height: 10.0,
                        width: 10.0,
                        child: CircularProgressIndicator()),
              ),
            ),
            const SizedBox(
              width: 5.0,
            ),
            Expanded(
                child: Text(
              characterData.name!,
              style: const TextStyle(color: Colors.white),
            ))
          ],
        ),
      ),
    );
  }
}
