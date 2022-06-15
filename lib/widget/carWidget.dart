import 'dart:ui';
import 'package:flutter/material.dart';

class CarWidget extends StatelessWidget {
  final String imageUrl;
  final String carType;
  final String time;
  final String money;
  final bool isSelected;
  const CarWidget({Key? key, required this.imageUrl, required this.carType, required this.time, required this.money, required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Column(
            children: [
              Image.network(
                imageUrl,
                width: 100,
                height: 80,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                carType,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(time),
              SizedBox(
                height: 5,
              ),
              Text(
                money,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        if (isSelected)
          Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: 0,
              child: Container(
                color: Colors.white.withOpacity(0.8),
              ))
      ],
    );
  }
}
