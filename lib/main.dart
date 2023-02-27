import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To do List',
      home: HomePages(),
    );
  }
}

class HomePages extends StatefulWidget {
  HomePages({
    super.key,
  });

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  List<String> todoList = [];

  final textC = TextEditingController();

  // assume we have a function to show an AlertDialog with a text field
Future<String?> showTextFieldDialog(BuildContext context, String currentValue) async {
  TextEditingController controller = TextEditingController(text: currentValue);
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title:const  Text("Edit Item"),
        content: TextFormField(
          controller: controller,
        ),
        actions: [
          TextButton(
            child:const Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child:const  Text("Save"),
            onPressed: () {
              String newValue = controller.text;
              Navigator.of(context).pop(newValue);
            },
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        actions: [
          IconButton(
            onPressed: () {
              addData(context, 'Add');
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Container(
        child: ListView.builder(
    itemCount: todoList.length,
    itemBuilder: (BuildContext context, int index) {
      String item = todoList[index];
      return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
          alignment: Alignment.center,
          child: const Text('delete'),
        ),
        child: ListTile(
          title: Text(item),
          trailing: IconButton(
            icon: const  Icon(Icons.edit),
            onPressed: () async {
              String? newValue = await showTextFieldDialog(context, item);
              if (newValue != null) {
                updateItem(index, newValue);
              }
            },
          ),
        ),
      );
    },
  )
      ),
    );
  }

  // assume we have a function to update an item in the list
  void updateItem(int index, String newValue) {
  setState(() {
    todoList[index] = newValue;
  });
  }

  Future<dynamic> addData(BuildContext context, String title) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            height: 100,
            child: Column(
              children: [
                TextField(
                  controller: textC,
                  decoration: const InputDecoration(hintText: 'text'),
                ),

                // or
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      todoList.add(textC.text);
                    });
                    Navigator.pop(context);
                    textC.clear();
                  },
                  child: Text(title),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
