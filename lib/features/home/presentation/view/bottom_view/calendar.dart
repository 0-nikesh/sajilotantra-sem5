import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _focusedDay = DateTime.now(); // Current date: March 4, 2025
  DateTime? _selectedDay;

  // Dummy events map
  final Map<DateTime, List<String>> _events = {
    DateTime(2025, 3, 7): ['Road Construction'],
    DateTime(2025, 3, 13): ['Holi'],
  };

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay; // Default to today
  }

  // Get events for a specific day
  List<String> _getEventsForDay(DateTime day) {
    return _events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Calendar Widget
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              color: Theme.of(context).cardColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TableCalendar(
                  firstDay: DateTime.utc(2025, 1, 1),
                  lastDay: DateTime.utc(2025, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay; // Update focused day too
                    });
                  },
                  eventLoader: _getEventsForDay,
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.4),
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    markerDecoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .error, // Red dots for events
                      shape: BoxShape.circle,
                    ),
                    outsideTextStyle: TextStyle(
                      color: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.color
                          ?.withOpacity(0.5),
                    ),
                    defaultTextStyle: Theme.of(context).textTheme.bodyMedium ??
                        const TextStyle(),
                    weekendTextStyle: Theme.of(context).textTheme.bodyMedium ??
                        const TextStyle(),
                  ),
                  headerStyle: HeaderStyle(
                    formatButtonVisible:
                        false, // Hide format button (e.g., week/month)
                    titleTextStyle: Theme.of(context).textTheme.titleMedium ??
                        const TextStyle(),
                    leftChevronIcon: Icon(Icons.chevron_left,
                        color: Theme.of(context).iconTheme.color),
                    rightChevronIcon: Icon(Icons.chevron_right,
                        color: Theme.of(context).iconTheme.color),
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: Theme.of(context).textTheme.bodySmall ??
                        const TextStyle(),
                    weekendStyle: Theme.of(context).textTheme.bodySmall ??
                        const TextStyle(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Selected Day Events
            Text(
              "Events for ${_selectedDay?.day ?? ''} ${_selectedDay != null ? DateTime(_selectedDay!.year, _selectedDay!.month).monthName : ''}, ${_selectedDay?.year ?? ''}",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _buildEventList(),
            ),
          ],
        ),
      ),
    );
  }

  // Build the list of events for the selected day
  Widget _buildEventList() {
    final events = _getEventsForDay(_selectedDay ?? DateTime.now());
    if (events.isEmpty) {
      return Center(
        child: Text(
          "No events for this day",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.color
                    ?.withOpacity(0.7),
              ),
        ),
      );
    }

    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Theme.of(context).cardColor,
          child: ListTile(
            leading: Icon(
              events[index] == "Road Construction"
                  ? Icons.construction
                  : Icons.celebration,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              events[index],
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        );
      },
    );
  }
}

// Extension to get month name
extension DateTimeExtension on DateTime {
  String get monthName {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }
}
