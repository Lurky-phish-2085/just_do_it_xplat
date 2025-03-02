import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Just Do It',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        ),
        home: const MyHomePage(title: 'Just Do It'),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var items = <Item>[];

  void addItem(Item item) {
    items.add(item);

    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20.0,
            children: <Widget>[Expanded(child: DoItList()), AddItemForm()],
          ),
        ),
      ),
    );
  }
}

class DoItList extends StatelessWidget {
  const DoItList({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return ListView(
      children: [
        for (var item in appState.items)
          Card(
            elevation: 1.0,
            child: ListTile(
              title: Center(child: Text(item.name)),
              titleTextStyle: Theme.of(context).textTheme.headlineLarge,
              leading: Checkbox(value: false, onChanged: (value) => value),
              trailing: Icon(Icons.delete),
            ),
          ),
      ],
    );
  }
}

class AddItemForm extends StatefulWidget {
  const AddItemForm({super.key});

  @override
  State<AddItemForm> createState() => _AddItemFormState();
}

class _AddItemFormState extends State<AddItemForm> {
  final _formKey = GlobalKey<FormState>();

  final textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Form(
      key: _formKey,
      child: Row(
        spacing: 20.0,
        children: [
          Expanded(
            child: TextFormField(
              controller: textFieldController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }

                return null;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your to-do list item',
              ),
            ),
          ),
          IconButton.filledTonal(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                appState.addItem(Item(name: textFieldController.text));
                textFieldController.text = '';
              }
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

class Item {
  Item({required this.name, this.checked = false});

  final String name;
  bool checked;

  bool toggleCheck() {
    checked = !checked;

    return checked;
  }
}
