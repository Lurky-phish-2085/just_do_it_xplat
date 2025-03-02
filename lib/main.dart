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
  var items = <ItemData>[];

  void addItem(ItemData item) {
    items.add(item);

    notifyListeners();
  }

  void toggleCheck(ItemData item) {
    item.toggleCheck();

    notifyListeners();
  }

  void removeItem(ItemData item) {
    items.remove(item);

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
    final appState = context.watch<MyAppState>();

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
            children: <Widget>[
              Expanded(
                child: DoItList(
                  items: appState.items,
                  onCheck: (item) => appState.toggleCheck(item),
                  onDelete: (item) => appState.removeItem(item),
                ),
              ),
              AddItemForm(
                onSubmit: (item) {
                  appState.addItem(item);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DoItList extends StatelessWidget {
  const DoItList({
    super.key,
    required this.items,
    required this.onCheck,
    required this.onDelete,
  });

  final Iterable<ItemData> items;
  final void Function(ItemData) onCheck;
  final void Function(ItemData) onDelete;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (var item in items)
          Item(
            item: item,
            onCheck: () => onCheck(item),
            onDelete: () => onDelete(item),
          ),
      ],
    );
  }
}

class Item extends StatelessWidget {
  const Item({
    super.key,
    required this.item,
    required this.onCheck,
    required this.onDelete,
  });

  final ItemData item;
  final void Function() onCheck;
  final void Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: item.checked ? Theme.of(context).colorScheme.outlineVariant : null,
      elevation: 1.0,
      child: ListTile(
        title: Center(
          child: Text(
            item.name,
            style:
                item.checked
                    ? TextStyle(decoration: TextDecoration.lineThrough)
                    : null,
          ),
        ),
        titleTextStyle: Theme.of(context).textTheme.headlineLarge,
        leading: Checkbox(
          value: item.checked,
          onChanged: (value) {
            onCheck();
          },
        ),
        trailing: IconButton(
          onPressed: () {
            onDelete();
          },
          icon: Icon(Icons.delete),
        ),
      ),
    );
  }
}

class AddItemForm extends StatefulWidget {
  const AddItemForm({super.key, required this.onSubmit});

  final void Function(ItemData item) onSubmit;

  @override
  State<AddItemForm> createState() => _AddItemFormState();
}

class _AddItemFormState extends State<AddItemForm> {
  final _formKey = GlobalKey<FormState>();

  final textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                widget.onSubmit(ItemData(textFieldController.text));
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

class ItemData {
  ItemData(this.name, {this.checked = false});

  final String name;
  bool checked;

  bool toggleCheck() {
    checked = !checked;

    return checked;
  }

  @override
  String toString() {
    return 'Item(name: $name, checked: $checked)';
  }
}
