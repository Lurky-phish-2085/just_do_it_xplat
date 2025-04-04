import 'dart:math';

import 'package:flutter/material.dart';
import 'package:just_do_it_xplat/database/database.dart';
import 'package:just_do_it_xplat/viewmodels/theme_viewmodel.dart';
import 'package:just_do_it_xplat/viewmodels/todo_list_viewmodel.dart';
import 'package:provider/provider.dart';

enum AddItemFormVariants { compact, expanded }

enum GreetingsVariants { welcome, motivational }

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<TodoListViewModel>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        actions: <Widget>[ChangeThemeButton()],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth <= 840) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: StreamBuilder<Iterable<Todo>>(
                  stream: appState.todos,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    final items = snapshot.data ?? [];

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 20.0,
                      children: <Widget>[
                        Greetings(
                          variant:
                              items.isNotEmpty
                                  ? GreetingsVariants.motivational
                                  : GreetingsVariants.welcome,
                        ),
                        StatsCard(items: items),
                        Expanded(
                          child: DoItList(
                            items: items,
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
                    );
                  },
                ),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: StreamBuilder<Iterable<Todo>>(
                stream: appState.todos,
                builder: (context, snapshot) {
                  final items = snapshot.data ?? [];

                  return Row(
                    spacing: 40.0,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 20.0,
                          children: [
                            Greetings(
                              variant:
                                  items.isNotEmpty
                                      ? GreetingsVariants.motivational
                                      : GreetingsVariants.welcome,
                            ),
                            AddItemForm(
                              onSubmit: (item) => appState.addItem(item),
                              variant: AddItemFormVariants.expanded,
                            ),
                            SizedBox(height: 128.0),
                            StatsCard(items: items),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: DoItList(
                          items: items,
                          onCheck: (item) => appState.toggleCheck(item),
                          onDelete: (item) => appState.removeItem(item),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

class ChangeThemeButton extends StatelessWidget {
  const ChangeThemeButton({super.key});

  IconData getThemeIcon(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.light:
        return Icons.light_mode;
      default:
        return Icons.palette;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<ThemeViewModel>();
    final themeIcon = getThemeIcon(appState.themeMode);

    return IconButton(
      onPressed:
          () => showDialog(
            context: context,
            barrierDismissible: true,
            builder:
                (BuildContext context) => AlertDialog(
                  title: const Text("Change Theme"),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        ListTile(
                          title: const Text("Dark"),
                          onTap: () {
                            appState.themeMode = ThemeMode.dark;
                          },
                          leading: Radio(
                            value: ThemeMode.dark,
                            groupValue: appState.themeMode,
                            onChanged: (ThemeMode? value) {
                              appState.themeMode = value!;
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text("Light"),
                          onTap: () {
                            appState.themeMode = ThemeMode.light;
                          },
                          leading: Radio(
                            value: ThemeMode.light,
                            groupValue: appState.themeMode,
                            onChanged: (ThemeMode? value) {
                              appState.themeMode = value!;
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text("Auto"),
                          onTap: () {
                            appState.themeMode = ThemeMode.system;
                          },
                          leading: Radio(
                            value: ThemeMode.system,
                            groupValue: appState.themeMode,
                            onChanged: (ThemeMode? value) {
                              appState.themeMode = value!;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Confirm"),
                    ),
                  ],
                ),
          ),
      icon: Icon(themeIcon),
    );
  }
}

class Greetings extends StatefulWidget {
  const Greetings({super.key, this.variant = GreetingsVariants.welcome});

  final GreetingsVariants variant;

  @override
  State<Greetings> createState() => _GreetingsState();
}

class _GreetingsState extends State<Greetings> {
  var _greeting = "";

  final _welcomeQuotes = const [
    "Welcome, back!",
    "What you will do?",
    "Looking good! B-)",
  ];

  final _motivationalQuotes = const [
    "Never Give UP!",
    "Deal with it!",
    "Just Do IT™",
  ];

  void initGreeting() {
    final random = Random();

    setState(() {
      _greeting =
          widget.variant == GreetingsVariants.welcome
              ? _welcomeQuotes[random.nextInt(_welcomeQuotes.length)]
              : _motivationalQuotes[random.nextInt(_motivationalQuotes.length)];
    });
  }

  @override
  void initState() {
    super.initState();
    initGreeting();
  }

  @override
  Widget build(BuildContext context) {
    return Text(_greeting, style: Theme.of(context).textTheme.displayMedium);
  }
}

class StatsCard extends StatelessWidget {
  const StatsCard({super.key, required this.items});

  final Iterable<Todo> items;

  @override
  Widget build(BuildContext context) {
    final numOfDoneItems = items.where((item) => item.done).toList().length;
    final numOfRemainingItems = items.length - numOfDoneItems;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Tasks Left: $numOfRemainingItems",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  "Done: $numOfDoneItems",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
            ElevatedButton(
              onPressed:
                  items.isNotEmpty
                      ? () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            behavior: SnackBarBehavior.floating,
                            showCloseIcon: true,
                            content: Text(
                              "Import Export Feature is not available yet.",
                            ),
                          ),
                        );
                      }
                      : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
              child: const Text("Import / Export"),
            ),
          ],
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

  final Iterable<Todo> items;
  final void Function(Todo)? onCheck;
  final void Function(Todo)? onDelete;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return EmptyListIndicator();
    }

    return ListView(
      children: [
        for (var item in items)
          Item(
            item: item,
            onCheck: () => onCheck?.call(item),
            onDelete: () => onDelete?.call(item),
          ),
      ],
    );
  }
}

class EmptyListIndicator extends StatelessWidget {
  const EmptyListIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wysiwyg, size: 100.0),
          SizedBox(height: 20.0),
          Text(
            "To-Do List Empty...\nPlease add one!",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
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

  final Todo item;
  final void Function()? onCheck;
  final void Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: item.done ? Theme.of(context).colorScheme.outlineVariant : null,
      elevation: 1.0,
      child: ListTile(
        title: Center(
          child: Text(
            item.title,
            style:
                item.done
                    ? TextStyle(decoration: TextDecoration.lineThrough)
                    : null,
          ),
        ),
        titleTextStyle: Theme.of(context).textTheme.headlineLarge,
        leading: Checkbox(
          value: item.done,
          onChanged: (value) {
            onCheck?.call();
          },
        ),
        trailing: IconButton(
          onPressed: () {
            onDelete?.call();
          },
          icon: Icon(Icons.delete),
        ),
      ),
    );
  }
}

class AddItemForm extends StatefulWidget {
  const AddItemForm({
    super.key,
    this.variant = AddItemFormVariants.compact,
    required this.onSubmit,
  });

  final AddItemFormVariants variant;
  final void Function(Todo item)? onSubmit;

  @override
  State<AddItemForm> createState() => _AddItemFormState();
}

class _AddItemFormState extends State<AddItemForm> {
  final _formKey = GlobalKey<FormState>();

  final textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.variant == AddItemFormVariants.compact) {
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
                  widget.onSubmit?.call(
                    Todo(
                      id: 0,
                      title: textFieldController.text,
                      done: false,
                      createdAt: null,
                    ),
                  );
                  textFieldController.text = '';
                }
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
      );
    } else {
      return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20.0,
          children: [
            TextFormField(
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
            ElevatedButton.icon(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  widget.onSubmit?.call(
                    Todo(
                      id: 0,
                      title: textFieldController.text,
                      done: false,
                      createdAt: null,
                    ),
                  );
                  textFieldController.text = '';
                }
              },
              icon: Icon(Icons.add),
              label: Text("Add"),
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(150, 70),
                iconSize: 40.0,
                textStyle: TextTheme.of(context).headlineSmall,
              ),
            ),
          ],
        ),
      );
    }
  }
}
