import 'package:flutter/material.dart';

class ExploreCard extends StatefulWidget {
  final String title;
  final String image;

  const ExploreCard({super.key, required this.title, required this.image});

  @override
  State<ExploreCard> createState() => _ExploreCardState();
}

class _ExploreCardState extends State<ExploreCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.15,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: const Color(0xFFA32EEB).withOpacity(0.1),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            height: MediaQuery.of(context).size.height * 0.11,
            child: Image.asset(
              widget.image,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.008,
          ),
          Text(
            widget.title,
            style: const TextStyle(fontSize: 18, color: Colors.purple),
          ),
        ],
      ),
    );
  }
}
