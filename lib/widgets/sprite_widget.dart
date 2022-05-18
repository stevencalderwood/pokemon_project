import 'package:flutter/material.dart';

class SpriteWidget extends StatelessWidget {
  final String url;
  const SpriteWidget({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
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
