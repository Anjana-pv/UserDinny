import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MenuImageview extends StatelessWidget {
  const MenuImageview({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.2,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data['menuCards'].length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Container(
                  height: MediaQuery.of(context).size.width * 0.2,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 11, 69, 31),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(15)),
                  child: CachedNetworkImage(
                    imageUrl: data['menuCards'][index] ?? '',
                      imageBuilder: (context, imageProvider) =>
                        Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => const Center(
                    child:SizedBox(
                        width: 20.0,
                        height: 20.0,
                        child: CircularProgressIndicator(
                              color: Color.fromARGB(255, 11, 49, 13),
                              backgroundColor:Color.fromARGB(255, 248, 248, 247),
                              value: 0.20,  
                        ),
                        ),
                        ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )),
            );
          }),
    );
  }
}
