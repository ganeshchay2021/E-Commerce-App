
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class ProductDescription extends StatelessWidget {
    final String description;

  const ProductDescription({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      style: const TextStyle(
        fontSize: 15,
      ),
      description,
      trimMode: TrimMode.Line,
      trimLines: 5,
      colorClickableText: Colors.pink,
      trimCollapsedText: 'Show more',
      trimExpandedText: 'Show less',
      moreStyle: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
