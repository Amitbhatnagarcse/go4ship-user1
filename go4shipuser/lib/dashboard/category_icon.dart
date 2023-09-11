// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CategoryIcons extends StatelessWidget {
  final String icon;
  final String title;
  final Color iconColor;
  const CategoryIcons({
    Key? key,
    required this.icon,
    required this.title,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(children: [

        Container(
            height: 100,
            width: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              color: iconColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: icon,
                      height: 50,
                      width: 50,
                      /*placeholder: (context, url) =>
                      const Center(
                          child: CircularProgressIndicator(color: Colors.green,)
                      ),*/
                      errorWidget: (context, url, error) => Center(
                        child: Image.asset(
                          'assets/icons/card.png',
                          height: 80,
                          width: 80,
                          color: Colors.green,
                        ),
                      ),
                    )/*SvgPicture.asset(
                  color: iconColor,
                  icon,
                  height: 40,
                  width: 40,
                )*/),
                const SizedBox(height: 5),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.black),
                )
              ],


            )),

      ]),
    );
  }
}
