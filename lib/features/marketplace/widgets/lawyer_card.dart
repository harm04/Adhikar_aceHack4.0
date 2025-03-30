import 'package:adhikar_acehack4_o/theme/pallete_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LawyerCard extends StatelessWidget {
  final String profilePic;
  final String lawyerName;
  final String location;
  final String ratings;
  final String caseWon;
  final String fees;
  final String experience;

  const LawyerCard(
      {super.key,
      required this.profilePic,
      required this.lawyerName,
      required this.location,
      required this.ratings,
      required this.caseWon,
      required this.fees,
      required this.experience});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        children: [
          //profile image
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
                color: Pallete.backgroundColor,
                borderRadius: BorderRadius.circular(15)),
            child: CachedNetworkImage(
              imageUrl: profilePic,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Image.network(
                  'https://img.freepik.com/free-psd/3d-rendered-image-businesswoman-with-gray-hair-wearing-glasses-holding-smartphone-she-looks-friendly-professional_632498-32049.jpg?t=st=1741332188~exp=1741335788~hmac=149581ab9f2c0b4f8c46f492ded19e16147e7cbba2015c07efa25a359904797e&w=740',
                  fit: BoxFit.cover),
              height: 70,
              width: 70,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          //lawyer name
                          Text(
                            lawyerName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          //experience
                          Text(
                            '($experience)',
                            style:
                                const TextStyle(color: Pallete.backgroundColor),
                          )
                        ],
                      ),
                      //ratings
                      Row(
                        children: [
                          const Text('4.0'),
                          const SizedBox(
                            width: 5,
                          ),
                          Image.asset(
                            'assets/icons/ic_star.png',
                            height: 18,
                          ),
                        ],
                      )
                    ],
                  ),
//address
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/ic_location.png',
                        height: 15,
                        color: Pallete.backgroundColor,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        location,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(color: Pallete.backgroundColor),
                      ),
                    ],
                  ),
                  //cases won 
                  Row(
                    children: [
                      const Text(
                        'Cases won : ',
                        style: TextStyle(color: Pallete.backgroundColor),
                      ),
                      Text(
                        caseWon,
                        style: const TextStyle(color: Pallete.backgroundColor),
                      ),
                    ],
                  ),
                  //fees
                  Row(
                    children: [
                      const Text(
                        'Fees : ',
                        style: TextStyle(color: Pallete.backgroundColor),
                      ),
                      Text(
                        fees,
                        style: const TextStyle(color: Pallete.backgroundColor),
                      ),
                    ],
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
