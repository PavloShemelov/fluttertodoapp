import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/todo.dart';
import '../constants/colors.dart';
import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchToDoList();
  }

  Future<void> _fetchToDoList() async {
    final querySnapshot = await _firestore.collection('todos').get();
    setState(() {
      _foundToDo = querySnapshot.docs.map((doc) => ToDo.fromFirestore(doc)).toList();
    });
  }

  void _addToDoItem(String toDo) async {
    final newToDo = ToDo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      todoText: toDo,
    );
    await _firestore.collection('todos').add(newToDo.toMap());
    _todoController.clear();
    _fetchToDoList();
  }

  void _handleToDoChange(ToDo todo) async {
    await _firestore.collection('todos').doc(todo.id).update({'isDone': !todo.isDone});
    _fetchToDoList();
  }

  void _deleteToDoItem(String id) async {
    await _firestore.collection('todos').doc(id).delete();
    _fetchToDoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: AppBar(
        backgroundColor: tdBGColor,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 20), // Add SizedBox to create space
            Container(
              height: 40,
              width: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/images/avatar.jpg'),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home), // Add icon next to text
              title: Text('Home'),
              onTap: () {
                // Implement functionality for the Home menu item
              },
            ),
            ListTile(
              leading: Icon(Icons.timer), // Add icon next to text
              title: Text('Timer'),
              onTap: () {
                // Implement functionality for the Timer menu item
              },
            ),
            ListTile(
              leading: Icon(Icons.settings), // Add icon next to text
              title: Text('Settings'),
              onTap: () {
                // Implement functionality for the Settings menu item
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_mail), // Add icon next to text
              title: Text('Contact us'),
              onTap: () {
                // Implement functionality for the Contact us menu item
              },
            ),
          ],
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                      hintText: 'Add a new todo item',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          _addToDoItem(_todoController.text);
                        },
                      ),
                    ),
                  ),
                ),
                ..._foundToDo.map((todo) => ToDoItem(
                  todo: todo,
                  onToDoChanged: _handleToDoChange,
                  onDeleteItem: _deleteToDoItem,
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}