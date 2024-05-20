import 'package:flutter/material.dart';
import '../../domain/entities/home.dart';

class PrayerTileWidget extends StatefulWidget {
  final HomeEntity homeEntity;

  const PrayerTileWidget({Key? key, required this.homeEntity,}) : super(key: key);

  @override
  _PrayerTileWidgetState createState() => _PrayerTileWidgetState();
}

class _PrayerTileWidgetState extends State<PrayerTileWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display Hijri Date Information
            if (widget.homeEntity.hijriDateEntity != null) ...[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Hijri Date: ${widget.homeEntity.hijriDateEntity?.date}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Day: ${widget.homeEntity.hijriDateEntity?.day}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Month: ${widget.homeEntity.hijriDateEntity?.hijriMonth?.enName} (${widget.homeEntity.hijriDateEntity?.hijriMonth?.arName})',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              if (widget.homeEntity.hijriDateEntity?.holidays != null &&
                  widget.homeEntity.hijriDateEntity!.holidays!.isNotEmpty)
                ...widget.homeEntity.hijriDateEntity!.holidays!.map(
                      (holiday) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Holiday: $holiday',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
            ],
            // Expandable Prayer Times Section
            if (isExpanded && widget.homeEntity.timings != null && widget.homeEntity.timings!.isNotEmpty) ...[
              const Divider(thickness: 2, height: 24),
              ...widget.homeEntity.timings!.map(
                    (timing) => ListTile(
                  leading: const Icon(
                    Icons.access_time,
                    color: Colors.blueAccent,
                  ),
                  title: Text(
                    timing.salatName ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey,
                    ),
                  ),
                  trailing: Text(
                    timing.salatTime ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.orangeAccent, // Highlight color
                    ),
                  ),
                ),
              ),
            ],

            // Expand/Collapse Button
            Center(
              child: IconButton(
                icon: Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
