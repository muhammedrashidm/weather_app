import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_weather/features/forecast/domain/entities/view_model.dart';

class HourWidget extends StatelessWidget {
  const HourWidget({
    super.key,
    required this.w,
    required this.isNow,
    required this.item,
    required this.textTheme,
  });

  final double w;
  final bool isNow;
  final AHourData item;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: w * .25,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          height: w * .25,
          width: w * .25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isNow
                ? Colors.white
                : const Color.fromRGBO(239, 239, 239, 1),
            boxShadow: !isNow
                ? null
                : [
              const BoxShadow(
                blurRadius: 22,
                color: Color(0xffa7a7a7),
                offset: Offset(
                  5,
                  5,
                ),
              ),
              const BoxShadow(
                blurRadius: 22,
                color: Color(0xffffffff),
                offset: Offset(
                  -5,
                  -5,
                ),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    Text(
                      item.temp.toString(),
                      style: textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600),
                    ),
                    const Text('°C')
                  ],
                ),
                Text(
                  DateFormat('hh:mm a').format(item.time),
                  style: textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
