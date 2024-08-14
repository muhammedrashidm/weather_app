import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SunData extends StatelessWidget {
  const SunData({
    super.key,
    required this.sunrise,
    required this.sunset,
  });
  final DateTime sunrise;
  final DateTime sunset;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Row(
          children: [
            const Icon(
              Icons.sunny,
              color: Colors.white,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              DateFormat('hh:mm a').format(sunrise),
              style: textTheme.bodyLarge?.copyWith(color: Colors.white),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const Icon(
              Icons.sunny_snowing,
              color: Colors.white,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              DateFormat('hh:mm a').format(sunset),
              style: textTheme.bodyLarge?.copyWith(color: Colors.white),
            )
          ],
        ),
      ],
    );
  }
}
