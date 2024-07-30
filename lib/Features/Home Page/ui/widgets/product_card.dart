import 'package:flutter/material.dart';
import 'package:myecomapp/Features/Home%20Page/model/product_model.dart';
import 'package:myecomapp/Features/Product%20Details%20Page/ui/pages/products_deatils_screen.dart';
import 'package:page_transition/page_transition.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
              child: ProductDetailsScreen(
                productId: product.id,
              ),
              type: PageTransitionType.fade),
        );
      },
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(15)),
            margin: const EdgeInsets.only(bottom: 10, top: 50),
          ),
          Positioned(
            top: 0,
            bottom: 15,
            left: 0,
            right: 0,
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Hero(
                    tag: product.name,
                    child: Image.asset(
                      "assets/images/product.png",
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    product.name,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16, height: 1),
                  ),
                  Text(
                    product.brand,
                    style: TextStyle(color: Colors.grey.shade500, height: 2),
                  ),
                  const Spacer(),
                  Text(
                    "\$${product.price}",
                    style: const TextStyle(color: Colors.pink, fontSize: 16),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
