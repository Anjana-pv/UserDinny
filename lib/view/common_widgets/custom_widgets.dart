

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

 
 Widget buildCard(BuildContext context,Map<String, dynamic> data) {
  String imageUrl = data['profileImage']?? '';
  String name = data['restaurantName']?? '';

  double containerWidthMultiplier = MediaQuery.of(context).size.width * 0.3;
  double containerHeightMultiplier = MediaQuery.of(context).size.width * 0.3;
  double borderRadiusMultiplier = MediaQuery.of(context).size.width * 0.04;
  double spacingMultiplier = MediaQuery.of(context).size.width * 0.02;
  double textSizeMultiplier = MediaQuery.of(context).size.width * 0.04;

  return Column(
    children: [
      Container(
        width: containerWidthMultiplier,
        height: containerHeightMultiplier,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadiusMultiplier),
        ),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadiusMultiplier),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                )),
          ),
          placeholder: (context, url) => Padding(
            padding: const EdgeInsets.all(48.0), 
            child: const CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
      SizedBox(
        height: spacingMultiplier,
      ),
      Text(
        name,
        style: TextStyle(
          fontSize: textSizeMultiplier,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}


   List<DropdownMenuItem<int>> getDropdownItems() {
    return [
      const DropdownMenuItem<int>(
        value: 2,
        child: Text('Two-Top'),
      ),
      const DropdownMenuItem<int>(
        value: 4,
        child: Text('Four-Top'),
      ),
      const DropdownMenuItem<int>(
        value: 6,
        child: Text('Six-Top'),
      ),
      const DropdownMenuItem<int>(
        value: 12,
        child: Text('Twelve-Top'),
      ),
    
    
    ];
}
