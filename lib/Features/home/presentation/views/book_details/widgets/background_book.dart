import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BackgroundBook extends StatelessWidget {
  const BackgroundBook({required this.imgUrl, super.key});

  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.57,
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: imgUrl,
            errorWidget: (context, url, error) => const Icon(
              Icons.error,
            ),
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            // Adjust blur strength
            child: Container(
              color:
                  Colors.grey.withOpacity(0.75), // Semi-transparent grey overlay
            ),
          ),
        ),
      ],
    );
  }
}
