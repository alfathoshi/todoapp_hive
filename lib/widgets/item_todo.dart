import 'package:flutter/material.dart';
import 'package:handson/model/todo.dart';

class ItemTodo extends StatefulWidget {
  final Todo todo;
  final bool check;
  final Function(bool?) onCheck;
  final Function() onEdit;
  final Function() onDelete;
  const ItemTodo({
    super.key,
    required this.check,
    required this.todo,
    required this.onCheck,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  State<ItemTodo> createState() => _ItemTodoState();
}

class _ItemTodoState extends State<ItemTodo> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          24,
        ),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            24,
          ),
        ),
        tileColor: widget.todo.isDone ? Colors.black26 : Colors.yellow[200],
        leading: Checkbox(
          activeColor: Colors.black,
          value: widget.check,
          onChanged: (value) => widget.onCheck(value),
        ),
        title: Text(
          widget.todo.title,
          style: TextStyle(
            decoration: widget.todo.isDone
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: Text(
          widget.todo.description,
          style: TextStyle(
            decoration: widget.todo.isDone
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: widget.onEdit,
                child: const Icon(Icons.edit),
              ),
            ),
            GestureDetector(
              onTap: widget.onDelete,
              child: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
