import 'package:get/get.dart';
import 'package:todo_app_getx/auth/auth.controller.dart';
import 'package:todo_app_getx/todo/models/todo.model.dart';
import 'package:todo_app_getx/todo/todo.service.dart';

class TodoController extends GetxController {
  static TodoController to = Get.find();
  RxList todos = [].obs;
  RxBool isLoadingTodos = false.obs;
  RxBool isAddingTodo = false.obs;
  RxBool isLoadingDetails = false.obs;
  late Todo activeTodo;
  late TodoService _todoService;
  TodoController() {
    _todoService = TodoService();
  }

  onInit() {
    todos.bindStream(loadTodos());
  }

  Stream<List<dynamic>> loadTodos() {
    AuthController authController = AuthController.to;
    return _todoService
        .findAll(authController.user.value!.uid)
        .map<List<dynamic>>((Iterable<Todo> todos) {
      return todos.map((todo) => todo.toJson()).toList();
    });
  }

  Future<Todo> loadDetails(String id) async {
    try {
      isLoadingDetails.value = true;
      activeTodo = await _todoService.findOne(id);
      print(activeTodo);
      isLoadingDetails.value = false;
      return activeTodo;
    } catch (e) {
      print("Error loading details: $e");
      isLoadingDetails.value = false;
      // Handle the error or return null, depending on your use case.
      return Todo();
    }
  }

  addTodo(String title) async {
    try {
      AuthController authController = AuthController.to;
      isAddingTodo.value = true;
      var todo =
          await _todoService.addOne(authController.user.value!.uid, title);
      todos.add(todo);
      Get.snackbar("Success", todo.title!, snackPosition: SnackPosition.BOTTOM);
      isAddingTodo.value = false;
    } catch (e) {
      isAddingTodo.value = false;
      print(e);
    }
  }

  updateTodo(Todo todo) async {
    try {
      isAddingTodo.value = true;
      await _todoService.updateOne(todo);
      int index = todos.value.indexWhere((element) => element.id == todo.id);

      todos[index] = todo;
      print(todos);
      Get.snackbar("Success", " updated", snackPosition: SnackPosition.BOTTOM);
      isAddingTodo.value = false;
    } catch (e) {
      isAddingTodo.value = false;
      print(e);
    }
  }

  deleteTodo(String id) async {
    try {
      await _todoService.deleteOne(id);
      int index = todos.value.indexWhere((element) => element.id == id);
      todos.removeAt(index);
      Get.snackbar("Success", "Deleted", snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      print(e);
    }
  }
}
