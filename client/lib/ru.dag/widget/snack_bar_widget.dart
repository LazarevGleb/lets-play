import 'package:flutter/material.dart';

class SnackBarWidget extends StatelessWidget {
  final String header;
  final String text;
  final Color color;

  const SnackBarWidget(
      {super.key,
      required this.header,
      required this.text,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            padding: const EdgeInsets.all(16),
            height: 90,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: color),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                          header),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                          style: const TextStyle(
                              fontSize: 14, color: Colors.white),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          text),
                    ],
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
