import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class HoursPanel extends StatelessWidget {
  final List<int>? enableTimes;
  final int startTime;
  final int endTime;
  final ValueChanged<int> onHourPressed;
  const HoursPanel(
      {super.key,
      required this.startTime,
      required this.endTime,
      required this.onHourPressed,
      this.enableTimes});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Selecione os horários de atendimento",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Wrap(
          spacing: 8,
          runSpacing: 16,
          children: [
            for (int i = startTime; i <= endTime; i++)
              TimeButton(
                enableTimes: enableTimes,
                label: '${i.toString().padLeft(2, '0')}:00',
                onPressed: onHourPressed,
                value: i,
              ),
          ],
        )
      ],
    );
  }
}

class TimeButton extends StatefulWidget {
  final List<int>? enableTimes;
  final String label;
  final int value;
  final ValueChanged<int> onPressed;

  const TimeButton({
    super.key,
    required this.label,
    required this.value,
    required this.onPressed,
    this.enableTimes,
  });

  @override
  State<TimeButton> createState() => _TimeButtonState();
}

class _TimeButtonState extends State<TimeButton> {
  var selected = false;

  @override
  Widget build(BuildContext context) {
    final textColor = selected ? Colors.white : ColorsConstants.grey;
    var buttomColor = selected ? ColorsConstants.brown : Colors.white;
    final buttonBorderColor =
        selected ? ColorsConstants.brown : ColorsConstants.grey;

    final TimeButton(:value, :label, :enableTimes) = widget;

    final disableTime = enableTimes != null && !enableTimes.contains(value);

    if (disableTime) {
      buttomColor = Colors.grey[400]!;
    }

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: disableTime
          ? null
          : () {
              setState(() {
                selected = !selected;
                widget.onPressed(value);
              });
            },
      child: Container(
        width: 64,
        height: 36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: buttomColor,
          border: Border.all(
            color: buttonBorderColor,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
