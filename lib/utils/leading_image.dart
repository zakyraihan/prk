import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget buildLeading(String? foto) {
  return foto != null && foto.isNotEmpty
      ? CachedNetworkImage(
          imageUrl: foto,
          height: 120,
          width: 70,
          fit: BoxFit.cover,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => Container(
            height: 120,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            height: 120,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.error, color: Colors.red),
          ),
        )
      : Container(
          height: 120,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(8),
          ),
        );
}
