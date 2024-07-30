import 'package:flutter/material.dart';

SliverAppBar myAppBar(BuildContext context, String titleText) {
  return SliverAppBar(
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        )),
    floating: true,
    centerTitle: true,
    backgroundColor: Theme.of(context).primaryColor,
    title: Text(
      titleText,
      style: const TextStyle(color: Colors.white),
    ),
  );
}
