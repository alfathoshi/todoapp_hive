import 'package:flutter/material.dart';
import 'package:handson/data/hive_database.dart';
import 'package:handson/model/todo.dart';
import 'package:handson/widgets/todo_textfield.dart';

class AddScreen extends StatefulWidget {
  final int? index;

  const AddScreen({
    super.key,
    this.index,
  });

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final hiveDatabase = HiveDatabase();
  Todo? _todo;

  Future<Todo?> loadTodo() async {
    if (widget.index != null) {
      _todo = await hiveDatabase.getTodoByIndex(widget.index!);
    }
    return _todo;
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text(
          widget.index != null ? 'Edit' : 'Add',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: loadTodo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TodoTextfield(
                    hint: 'Title',
                    controller: titleController
                      ..text = _todo != null ? _todo!.title : '',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TodoTextfield(
                    hint: 'Description',
                    controller: descController
                      ..text = _todo != null ? _todo!.description : '',
                    maxLines: 6,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                    ),
                    onPressed: () async {
                      if (widget.index != null) {
                        _todo = Todo(
                          title: titleController.text,
                          description: descController.text,
                        );
                        await hiveDatabase.updateTodo(widget.index!, _todo!);
                      } else {
                        final todo = Todo(
                          title: titleController.text,
                          description: descController.text,
                        );
                        await hiveDatabase.addTodo(todo);
                        if (context.mounted) Navigator.pop(context);
                      }
                    },
                    child: Text(
                      widget.index != null ? 'Edit' : 'Add',
                    ),
                  )
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
