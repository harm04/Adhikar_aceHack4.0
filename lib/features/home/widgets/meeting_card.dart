import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MeetingCard extends StatefulWidget {
  final String lawyerName;
  final String clientName;
  final String time;
  final String date;
  final String status;
  final String lawyerProfImage;

  const MeetingCard({
    super.key,
    required this.lawyerName,
    required this.time,
    required this.date,
    required this.status,
    required this.lawyerProfImage,
    required this.clientName,
  });

  @override
  State<MeetingCard> createState() => _MeetingCardState();
}

class _MeetingCardState extends State<MeetingCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              // Profile Image with Curved Border
              ClipRRect(
                borderRadius: BorderRadius.circular(15), // Curved border
                child: CachedNetworkImage(
                  imageUrl: widget.lawyerProfImage,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGkAznCVTAALTD1o2mAnGLudN9r-bY6klRFB35J2hY7gvR9vDO3bPY_6gaOrfV0IHEIUo&usqp=CAU',
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 90,
                  width: 90,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              // Lawyer Name and Details
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.lawyerName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      // Time and Date
                      Row(
                        children: [
                          Image.asset(
                            'assets/icons/ic_clock.png',
                            height: 15,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            '${widget.date} at ${widget.time}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(color: Colors.black87),
                          ),
                        ],
                      ),
                      // Status
                      Row(
                        children: [
                          const Text(
                            'Status: ',
                            style: TextStyle(color: Colors.black87),
                          ),
                          Text(
                            widget.status,
                            style: TextStyle(
                                color: widget.status.toLowerCase() == 'pending'
                                    ? Colors.red
                                    : Colors.green),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
