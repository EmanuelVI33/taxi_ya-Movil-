import 'package:flutter/material.dart';

class SelectImage extends StatelessWidget {
  final String label;
  const SelectImage({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          Text(label),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {},
                child: Icon(
                  Icons.browse_gallery_rounded,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              TextButton(
                onPressed: () {},
                child: Icon(Icons.browse_gallery_rounded),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
