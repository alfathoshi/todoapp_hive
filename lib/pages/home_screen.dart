import 'package:flutter/material.dart';
import 'package:handson/data/hive_database.dart';
import 'package:handson/model/todo.dart';
import 'package:handson/widgets/item_todo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Todo? _todo;
  final HiveDatabase hiveDatabase = HiveDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: AppBar(
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
                  ? const Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Empty'),
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
                              return ItemTodo(
                                  check: todos[index].isDone,
                                  todo: todos[index],
                                  onCheck: (value) async {
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
                                  onEdit: () {
                                    Navigator.pushNamed(context, '/add')
                                        .then((value) {
                                      setState(() {});
                                    });
                                  });
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
