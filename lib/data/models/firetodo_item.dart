import 'package:firetodo/data/data.dart';
import 'package:flutter/material.dart';

/// [FireTodoItem] is out main data model for storing and getting the todolist
/// data from and to the Firebase firestore
class FireTodoItem {
  // TODO: 1. Add the properties here.
  final String id;
  final String title;
  final FireTodoPriority priority;
  final FireTodoStatus status;
  final String description;
  final DateTime date;

  FireTodoItem({
    required this.id,
    required this.title,
    required this.priority,
    required this.status,
    required this.description,
    required this.date,
  });

  factory FireTodoItem.fromJson(Map<String, dynamic> json) {
    // TODO: 2. Complete the fromJson factory method here.
    return FireTodoItem(
      id: json['id'],
      title: json['title'],
      priority: FireTodoPriority.fromId(json['priority']),
      status: FireTodoStatus.fromId(json['status']),
      description: json['description'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    // TODO: 3. Complete the toJson factory method here.
    return {
      'id': id,
      'title': title,
      'priority': priority.id,
      'status': status.id,
      'description': description,
      'date': date.toString(),
    };
  }

  FireTodoItem copyWith({
    String? id,
    String? title,
    FireTodoPriority? priority,
    FireTodoStatus? status,
    String? description,
    DateTime? date,
  }) {
    return FireTodoItem(
      id: id ?? this.id,
      title: title ?? this.title,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      description: description ?? this.description,
      date: date ?? this.date,
    );
  }
}
