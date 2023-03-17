import 'package:flutter/material.dart';

class EventWidget extends StatelessWidget {
  const EventWidget({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      child: Container(
        height: 90,
        width: MediaQuery.of(context).size.width * 0.65,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              stops: [0.03, 0.03], colors: [Colors.indigo, Colors.black12]),
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 16),
              child: Column(
                children: [
                  Text(
                    "Meta$index",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: const [
                      Icon(Icons.menu),
                      SizedBox(width: 6),
                      Icon(Icons.draw)
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: Icon(Icons.star_border, size: 26),
            )
          ],
        ),
      ),
    );
  }
}
