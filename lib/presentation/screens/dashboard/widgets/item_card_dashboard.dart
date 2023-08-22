import 'package:flutter/material.dart';
import 'package:avangmine_riverpod/config/config.dart';
import 'package:avangmine_riverpod/presentation/screens/widgets_common/widgets_common.dart';

class CardDashboardWidget extends StatelessWidget {
  const CardDashboardWidget({
    Key? key,
    required this.counter,
    required this.description,
    required this.icon,
    required this.colorCard,
    this.error = false,
  }) : super(key: key);

  final String counter;
  final String description;
  final IconData icon;
  final dynamic colorCard;
  final bool error;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textTheme =
        Theme.of(context).textTheme.apply(displayColor: theme.onSurface);

    return Container(
      constraints: const BoxConstraints(minHeight: 160),
      decoration: BoxDecoration(
        color: colorCard is Color ? colorCard : null,
        gradient: colorCard is LinearGradient ? colorCard : null,
        borderRadius: BorderRadius.circular(8),
        border: colorCard is Color
            ? Border.all(color: warningYellow6, width: 1)
            : null,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color:
                    colorCard is LinearGradient ? Colors.white : Colors.black,
                size: 40,
              ),
              const SizedBox(width: 8),
              if (counter != '?') ...{
                Flexible(
                    child: CounterWidget(
                  count: double.parse(counter),
                  floating:
                      counter.contains('.') ? counter.split('.')[1].length : 0,
                  textStyle: textTheme.displaySmall!.copyWith(
                      color: colorCard is LinearGradient
                          ? Colors.white
                          : Colors.black),
                ))
              } else ...{
                Text('?',
                    style: textTheme.displaySmall!.copyWith(
                      color: error
                          ? Colors.red
                          : colorCard is LinearGradient
                              ? Colors.white
                              : Colors.black,
                    ))
              }
            ],
          ),
          Text(
            description,
            style: TextStyle(
                color:
                    colorCard is LinearGradient ? Colors.white : Colors.black),
          )
        ],
      ),
    );
  }
}
