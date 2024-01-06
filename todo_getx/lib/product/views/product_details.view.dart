import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_getx/product/product.controller.dart';

class ProductDetailsPage extends StatefulWidget {
  ProductDetailsPage({Key? key}) : super(key: key);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  ProductController productController = ProductController.to;
  late String productId; // Declare productId variable

  @override
  Widget build(BuildContext context) {
    // Extract the productId from the route parameters
    productId = Get.parameters["product_id"] ?? "";

    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: GetX(
        initState: (state) {
          productController.loadDetails(productId);
        },
        builder: (disposable) {
          if (productController.isLoadingDetails) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (productController.errorLoadingDetails) {
            return Container(
              child: Center(
                child: TextButton(
                  child: Text("Reload"),
                  onPressed: () {
                    productController.loadDetails(productId);
                  },
                ),
              ),
            );
          }

          return Column(
            children: <Widget>[
              CarouselSlider(
                options: CarouselOptions(height: 200.0),
                items: productController.activeProduct.gallery!.map((image) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            image: DecorationImage(
                              image: NetworkImage(
                                image.url,
                              ),
                              fit: BoxFit.cover,
                            )),
                      );
                    },
                  );
                }).toList(),
              ),
              Text("${productController.activeProduct.name}"),
            ],
          );
        },
      ),
    );
  }
}
