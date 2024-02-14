import 'package:flutter/material.dart';
import 'package:handson/data/hive_database.dart';
import 'package:handson/model/todo.dart';
import 'package:handson/pages/add_screen.dart';
import 'package:handson/widgets/item_todo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Todo? _todo;
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final HiveDatabase hiveDatabase = HiveDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        shadowColor: Colors.black,
        elevation: 2,
        backgroundColor: Colors.yellow,
        title: const Text(
          'To Do App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: hiveDatabase.getTodos(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data!.length;
              final active = snapshot.data!
                  .map((todo) => todo.isDone)
                  .where((element) => element == false)
                  .toList()
                  .length;
              return snapshot.data!.isEmpty
                  ? Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/emptyBox.png',
                          scale: 0.7,
                        ),
                        const Text('Empty'),
                      ],
                    ))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            '$active active tasks out of $data',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              final todos = snapshot.data!;
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: ItemTodo(
                                    check: todos[index].isDone,
                                    todo: todos[index],
                                    onCheck: (value) async {
                                      _todo = Todo(
                                        title: todos[index].title,
                                        description: todos[index].description,
                                        isDone: todos[index].isDone,
                                      );
                                      setState(() {
                                        todos[index].isDone =
                                            !todos[index].isDone;
                                      });
                                      await hiveDatabase.updateStatus(
                                          index, _todo!);
                                    },
                                    onDelete: () {
                                      setState(() {
                                        hiveDatabase.deleteTodo(index);
                                      });
                                    },
                                    onEdit: () async {
                                      _todo = Todo(
                                        title: todos[index].title,
                                        description: todos[index].description,
                                        isDone: todos[index].isDone,
                                      );
                                      await Navigator.pushNamed(context, '/add',
                                              arguments: index)
                                          .then((value) {
                                        setState(() {});
                                      });
                                    }),
                              );
                            },
                          ),
                        )
                      ],
                    );
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        onPressed: () {
          Navigator.pushNamed(context, '/add').then((value) {
            setState(() {});
          });
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
