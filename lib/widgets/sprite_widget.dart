import 'package:flutter/material.dart';
import 'package:pokemon_project/models/sprite.dart';

class SpriteWidget extends StatelessWidget {
  final Sprite sprite;
  const SpriteWidget({Key? key, required this.sprite}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _ImageWidget(url: sprite.front),
        _ImageWidget(url: sprite.back),
      ],
    );
  }
}

class _ImageWidget extends StatelessWidget {
  final String? url;
  const _ImageWidget({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return url == null
        ? Container()
        : Image.network(
            url!,
            height: MediaQuery.of(context).size.width * 0.5,
            fit: BoxFit.contain,
            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return SizedBox(
                height: MediaQuery.of(context).size.width * 0.5,
                width: MediaQuery.of(context).size.width * 0.5,
                child: Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                ),
              );
            },
          );
  }
}
