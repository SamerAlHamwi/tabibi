import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/app/data/http/app_links.dart';

class DoctorCardWidget extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String specialty;
  // final double rating;
  // final double price;
  final int reviews;
  final VoidCallback onTap;

  const
  DoctorCardWidget({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.specialty,
    // required this.rating,
    required this.reviews,
    required this.onTap,
    // required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: imageUrl.isNotEmpty
                    ? NetworkImage('${AppLink.imageBase}$imageUrl')
                    : const AssetImage('assets/images/empty_image.jpg') as ImageProvider,
                radius: 24,
              ),

              const SizedBox(width: 8),
              Expanded(
                child: Text(name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Text(specialty,
                  style: TextStyle(
                      color: Colors.grey.shade600, fontSize: 12)),

            ],
          ),
          // const SizedBox(height: 20),
          const Spacer(),
          Row(
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row(
                  //   mainAxisAlignment:MainAxisAlignment.start ,
                  //   children: [
                  //     Icon(Icons.star, color: Colors.amber, size: 18),
                  //     SizedBox(width: 4),
                  //     // Text(
                  //     //   rating.toString(),
                  //     //   style: const TextStyle(fontWeight: FontWeight.bold),
                  //     // ),
                  //
                  //   ],
                  // ),
                  // Text("($reviews Reviews)",
                  //     style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                ],
              ),
              const Spacer(),
              InkWell(
                onTap: onTap,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade100,
                  ),
                  child: const Icon(Icons.arrow_forward, size: 20),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
