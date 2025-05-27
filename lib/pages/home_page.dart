import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todofr/data/database.dart';
import 'package:todofr/util/dialog_box.dart';
import 'package:todofr/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference to the Hive box
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // if this is the first time opening the app, create initial data
    if (_myBox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      // load the data from the database
      db.loadData();
    }
    super.initState();
  }

  // text controller
  final TextEditingController controller = TextEditingController();

  // checkbox changed
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase(); // update the database
  }

  // save a new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([controller.text, false]);
    });
    Navigator.of(context).pop(); // close the dialog
    db.updateDataBase(); // update the database
  }

  void cancelNewTask() {
    controller.clear(); // clear the text field
    Navigator.of(context).pop(); // ckose the dialog
    db.updateDataBase(); // update the database
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  // delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase(); // update the database
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text('TO DO APP: FOR REAL'),
        elevation: 0,
        backgroundColor: Colors.yellow,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colors.yellow[400],
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
