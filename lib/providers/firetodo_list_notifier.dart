import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../data/models/models.dart';
import 'firetodo_request_state.dart';

class FireTodoListNotifier extends ChangeNotifier {
  // TODO: 1. Add FireTodoListNotifier implementation

  var _todoList = <FireTodoItem>[];
  List<FireTodoItem> get todoList => _todoList;

  var _todoListState = FireTodoRequestState.initial;
  FireTodoRequestState get todoListState => _todoListState;

  var _todoState = FireTodoRequestState.initial;
  FireTodoRequestState get todoState => _todoState;

  Future<void> getTodoList({required DateTime dateTime}) async {
    // TODO: 2. Add getTodoList implementation
    _todoListState = FireTodoRequestState.loading;
    notifyListeners();
    try {
      final db = FirebaseFirestore.instance;
      final querysnapshot = await db.collection(dateTime.toString()).get();

      final todoList = querysnapshot.docs.map((item) {
        return FireTodoItem.fromJson(item.data());
      }).toList();

      _todoListState = FireTodoRequestState.success;
      _todoList = todoList;
      notifyListeners();
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());

      _todoListState = FireTodoRequestState.error;
      notifyListeners();
    }
  }

  Future<void> addUpdateTodo(FireTodoItem todo) async {
    // TODO: 3. Add addUpdateTodo implementation
    _todoState = FireTodoRequestState.loading;
    notifyListeners();
    try {
      await FirebaseFirestore.instance
          .collection(todo.date.toString())
          .doc(todo.id)
          .set(todo.toJson());
      _todoState = FireTodoRequestState.success;
      notifyListeners();
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      _todoState = FireTodoRequestState.error;
      notifyListeners();
    }
  }

  Future<void> deleteTodo(FireTodoItem todo) async {
    // TODO: 4. Add deleteTodo implementation
    _todoState = FireTodoRequestState.loading;
    notifyListeners();
    try {
      await FirebaseFirestore.instance
          .collection(todo.date.toString())
          .doc(todo.id)
          .delete();
      _todoState = FireTodoRequestState.success;
      notifyListeners();
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      _todoState = FireTodoRequestState.error;
      notifyListeners();
    }
  }
}
