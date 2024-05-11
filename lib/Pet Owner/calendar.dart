import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'services.dart';
import 'petshop_page.dart';
import 'pets_page.dart';
import 'pet_home_page.dart';
import 'Side_Pages/notifications_page.dart';

// Define the Event class to hold event data
class Event {
  final String title;
  final DateTime dateTime;

  Event({required this.title, required this.dateTime});
}

// AddReminderPage allows user to create a new reminder
class AddReminderPage extends StatefulWidget {
  final Function(Event) onAdd;

  AddReminderPage({required this.onAdd});

  @override
  _AddReminderPageState createState() => _AddReminderPageState();
}

class _AddReminderPageState extends State<AddReminderPage> {
  late TextEditingController _titleController;
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Reminder'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Reminder Title'),
            ),
            ListTile(
              title: Text("Date: ${_selectedDate.toLocal()}".split(' ')[0]),
              trailing: Icon(Icons.keyboard_arrow_down),
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );
                if (picked != null && picked != _selectedDate)
                  setState(() {
                    _selectedDate = picked;
                  });
              },
            ),
            ListTile(
              title: Text("Time: ${_selectedTime.format(context)}"),
              trailing: Icon(Icons.keyboard_arrow_down),
              onTap: () async {
                final TimeOfDay? picked =
                await showTimePicker(
                  context: context,
                  initialTime: _selectedTime,
                );
                if (picked != null && picked != _selectedTime)
                  setState(() {
                    _selectedTime = picked;
                  });
              },
            ),
            ElevatedButton(
              onPressed: () {
                final DateTime reminderDateTime = DateTime(
                  _selectedDate.year,
                  _selectedDate.month,
                  _selectedDate.day,
                  _selectedTime.hour,
                  _selectedTime.minute,
                );
                widget.onAdd(Event(
                  title: _titleController.text,
                  dateTime: reminderDateTime,
                ));
                Navigator.pop(context);
              },
              child: Text('Add Reminder'),
            ),
          ],
        ),
      ),
    );
  }
}

// CalendarWidget allows selection and display of events per day
class CalendarWidget extends StatefulWidget {
  final Map<DateTime, List<Event>> events;

  CalendarWidget({required this.events});

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  late List<Event> _selectedEvents;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
    _selectedEvents = widget.events[_selectedDay] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay; // update _focusedDay here as well
              _selectedEvents = widget.events[selectedDay] ?? [];
            });
          },
          eventLoader: (day) {
            return widget.events[day] ?? [];
          },
          calendarBuilders: CalendarBuilders(
            markerBuilder: (context, date, events) {
              if (events.isNotEmpty) {
                return Positioned(
                  right: 1,
                  top: 1,
                  child: _buildEventsMarker(date, events),
                );
              }
            },
          ),
        ),
        Expanded(
          child: _buildEventList(),
        ),
      ],
    );
  }

  Widget _buildEventsMarker(DateTime date, List<dynamic> events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red,
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildEventList() {
    if (_selectedEvents.isEmpty) {
      return Center(
        child: Text('No events for this day'),
      );
    } else {
      _selectedEvents.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      return ListView.builder(
        itemCount: _selectedEvents.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_selectedEvents[index].title),
            subtitle: Text('${_selectedEvents[index].dateTime.hour}:${_selectedEvents[index].dateTime.minute}'),
          );
        },
      );
    }
  }
}

// Main page setup with a floating action button and navigation logic
class CalendarPage extends StatelessWidget {
  final Map<DateTime, List<Event>> events = {};

  void addEvent(Event event) {
    final list = events[event.dateTime] ?? [];
    list.add(event);
    events[event.dateTime] = list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
        automaticallyImplyLeading: false,
      ),
      body: CalendarWidget(events: events),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddReminderPage(onAdd: addEvent),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

