import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_getx/product/models/product.model.dart';
import 'package:todo_app_getx/widgets/app_cached_image.dart';

class SingleProduct extends StatelessWidget {
  final Product product;
  const SingleProduct({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed("products/${product.id}/view");
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.black,
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(child: Image.network(product.gallery!.first.url)),
            Text(product.name!),
            Text(product.desc!),
            Text("\$ ${product.price}"),
          ],
        ),
      ),
    );
  }
}

class AppCachedImage extends StatefulWidget {
  final String? url; // Make the url parameter nullable
  final Widget Function(BuildContext, ImageProvider<dynamic>) imageBuilder;

  AppCachedImage({Key? key, this.url, required this.imageBuilder})
      : super(key: key);

  @override
  _AppCachedImageState createState() => _AppCachedImageState();
}

class _AppCachedImageState extends State<AppCachedImage> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.url ?? "", // Use the null-aware operator to handle null
      placeholder: (context, url) {
        return widget.imageBuilder.call(
          context,
          AssetImage("assets/images/loading_image.gif"),
        );
      },
      errorWidget: (context, url, error) {
        return widget.imageBuilder.call(
          context,
          AssetImage("assets/images/default_image.jpg"),
        );
      },
    );
  }
}
