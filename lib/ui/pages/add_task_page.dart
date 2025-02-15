import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/ui/theme.dart';
import 'package:to_do/ui/widgets/app_bar.dart';
import 'package:to_do/ui/widgets/button.dart';
import '../../controllers/task_controller.dart';

import '../widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  TimeOfDay? _lastSelectedStartTime;
  TimeOfDay? _lastSelectedEndTime;

  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();

  int _selectedReminder = 5;
  List<int> remindList = [5, 10, 15, 20];

  String _selectedRepeat = 'None';
  List<String> repeats = ['None', 'Daily', 'Weekly', 'Monthly'];

  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(icon: 'addTask', function: () => Get.back()),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Add Task',
                style: TextTheme.of(context).headlineLarge,
              ),
              InputField(
                title: 'Title',
                hint: 'Enter title here',
                controller: _titleController,
              ),
              InputField(
                title: 'Note',
                hint: 'Enter note here',
                controller: _noteController,
              ),
              InputField(
                title: 'Date',
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  onPressed: () => _getDateFromUser(),
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      title: 'Start Time',
                      hint: _startTime,
                      widget: IconButton(
                        onPressed: () => _getTimeFromUser(isStartTime: true),
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: InputField(
                      title: 'End Time',
                      hint: _endTime,
                      widget: IconButton(
                        onPressed: () => _getTimeFromUser(isStartTime: false),
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              InputField(
                title: 'Remind',
                hint: '$_selectedReminder minutes early',
                widget: Row(
                  children: [
                    DropdownButton(
                      dropdownColor: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(10),
                      items: remindList
                          .map<DropdownMenuItem<int>>(
                            (value) => DropdownMenuItem(
                              value: value,
                              child: Text(
                                '$value',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey,
                      ),
                      iconSize: 32,
                      elevation: 4,
                      underline: Container(
                        height: 0,
                      ),
                      onChanged: (int? newValue) {
                        setState(() {
                          _selectedReminder = newValue!;
                        });
                      },
                    ),
                    const SizedBox(width: 6),
                  ],
                ),
              ),
              InputField(
                title: 'Repeat',
                hint: _selectedRepeat,
                widget: Row(
                  children: [
                    DropdownButton(
                      dropdownColor: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(10),
                      items: repeats
                          .map<DropdownMenuItem<String>>(
                            (value) => DropdownMenuItem(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey,
                      ),
                      iconSize: 32,
                      elevation: 4,
                      underline: Container(
                        height: 0,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedRepeat = newValue!;
                        });
                      },
                    ),
                    const SizedBox(width: 6),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPalette(),
                  MyButton(
                    label: 'Create Task',
                    onTap: () {
                      _validateData();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validateData() {
    DateTime now = DateTime.now();
    DateTime selectedDate = _selectedDate;

    DateTime selectedStartTime = DateFormat('hh:mm a').parse(_startTime);
    DateTime selectedEndTime = DateFormat('hh:mm a').parse(_endTime);

    selectedStartTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedStartTime.hour,
      selectedStartTime.minute,
    );

    selectedEndTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedEndTime.hour,
      selectedEndTime.minute,
    );

    if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar('Required', 'Fill title field and note field',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withValues(alpha: 0.9),
          colorText: Theme.of(context).cardColor,
          icon: Icon(
            Icons.warning_amber_rounded,
            color: Theme.of(context).cardColor,
          ));
      return;
    }

    if (selectedStartTime.isBefore(now)) {
      Get.snackbar(
          'Required', 'Start time must be in the future if it is today',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withValues(alpha: 0.9),
          colorText: Theme.of(context).cardColor,
          icon: Icon(
            Icons.warning_amber_rounded,
            color: Theme.of(context).cardColor,
          ));
      return;
    }

    if (selectedEndTime.isBefore(selectedStartTime)) {
      Get.snackbar('Required', 'End time must be after start time',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withValues(alpha: 0.9),
          colorText: Theme.of(context).cardColor,
          icon: Icon(
            Icons.warning_amber_rounded,
            color: Theme.of(context).cardColor,
          ));
      return;
    }

    int remindMinutes = _selectedReminder;
    DateTime reminderTime =
        selectedStartTime.subtract(Duration(minutes: remindMinutes));

    if (reminderTime.isBefore(now)) {
      Get.snackbar('Invalid Reminder', 'Reminder time has already passed!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withValues(alpha: 0.9),
          colorText: Theme.of(context).cardColor,
          icon: Icon(
            Icons.warning_amber_rounded,
            color: Theme.of(context).cardColor,
          ));
      return;
    }

    _addTaskToDb();
    Get.back();
  }

  _addTaskToDb() async {
    int value = await _taskController.addTask(
        task: Task(
      title: _titleController.text,
      note: _noteController.text,
      isCompleted: 0,
      date: DateFormat.yMd().format(_selectedDate),
      startTime: _startTime,
      endTime: _endTime,
      color: _selectedColor,
      remind: _selectedReminder,
      repeat: _selectedRepeat,
    ));
  }

  Widget _colorPalette() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: titleStyle,
        ),
        const SizedBox(height: 8),
        Wrap(
          children: List<Widget>.generate(
              3,
              (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedColor = index;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: CircleAvatar(
                        backgroundColor: index == 0
                            ? primaryClr
                            : index == 1
                                ? pinkClr
                                : orangeClr,
                        radius: 14,
                        child: _selectedColor == index
                            ? const Icon(Icons.done,
                                size: 16, color: Colors.white)
                            : null,
                      ),
                    ),
                  )),
        ),
      ],
    );
  }

  void _getDateFromUser() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() => _selectedDate = pickedDate);
    }
  }

  void _getTimeFromUser({required bool isStartTime}) async {
    TimeOfDay? _pickedTime = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.input,
      initialTime: isStartTime
          ? _lastSelectedStartTime ?? (TimeOfDay.fromDateTime(DateTime.now()))
          : _lastSelectedEndTime ??
              (TimeOfDay.fromDateTime(
                  DateTime.now().add(const Duration(minutes: 20)))),
    );

    if (_pickedTime != null) {
      String _formattedTime = _pickedTime.format(context);
      setState(() {
        if (isStartTime) {
          _startTime = _formattedTime;
          _lastSelectedStartTime = _pickedTime;
        } else {
          _endTime = _formattedTime;
          _lastSelectedEndTime = _pickedTime;
        }
      });
    }
  }
}
