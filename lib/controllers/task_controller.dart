import 'package:get/get.dart';
import 'package:to_do/db/db_helper.dart';
import 'package:to_do/models/task.dart';

class TaskController extends GetxController {
  final taskList = <Task>[].obs;

  Future<int> addTask({required Task task}) {
    return DBHelper.insert(task);
  }

  Future<void> getTasks() async {
    final List<Map<String, Object?>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }

  void deleteTasks({required Task task}) async {
    await DBHelper.delete(task);
    await getTasks();
  }

  void markTaskAsCompleted({required int id}) async {
    await DBHelper.update(id);
    await getTasks();
  }
}
