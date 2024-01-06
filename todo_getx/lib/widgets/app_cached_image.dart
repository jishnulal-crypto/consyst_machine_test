import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppCachedImage extends StatefulWidget {
  final String? url; // Make the 'url' parameter nullable
  final Widget Function(BuildContext, ImageProvider<dynamic>)? imageBuilder; // Make the 'imageBuilder' parameter nullable
  AppCachedImage({Key? key, this.url, this.imageBuilder})
      : super(key: key);

  @override
  _AppCachedImageState createState() => _AppCachedImageState();
}

class _AppCachedImageState extends State<AppCachedImage> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.url ?? '', // Use the null-aware operator ?? to provide a default value if 'url' is null
      placeholder: (context, url) {
        return widget.imageBuilder?.call(
              context,
              AssetImage("assets/images/loading_image.gif"),
            ) ??
            const SizedBox(); // Provide a default value if 'imageBuilder' is null
      },
      errorWidget: (context, url, error) {
        return widget.imageBuilder?.call(
              context,
              AssetImage("assets/images/default_image.jpg"),
            ) ??
            const SizedBox(); // Provide a default value if 'imageBuilder' is null
      },
    );
  }
}
