import 'package:flutter/material.dart';

import 'package:myecomapp/Features/Cat%20Page/model/cart_model.dart';
import 'package:myecomapp/Features/Order%20Details/ui/widgets/user_details_text.dart';

class OrderProductCard extends StatefulWidget {
  final CartModel cart;
  const OrderProductCard({
    super.key,
    required this.cart,
  });

  @override
  State<OrderProductCard> createState() => _OrderProductCardState();
}

class _OrderProductCardState extends State<OrderProductCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Stack(
        children: [
          const SizedBox(
            width: double.infinity,
          ),
          Container(
            margin: const EdgeInsets.only(left: 50),
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(18)),
          ),
          SizedBox(
            child: Row(
              children: [
                Image.asset(
                  "assets/images/product.png",
                  height: 100,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        maxLines: 2,
                        widget.cart.product.name,
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        maxLines: 1,
                        widget.cart.product.brand,
                        style: const TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          MyRichText(
                              title: "Quantity: ",
                              text: "${widget.cart.quantity}"),
                        ],
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        "\$${widget.cart.product.price}",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
