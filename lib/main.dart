import 'package:flutter/material.dart';
import 'package:just_do_it_xplat/models/todo_model.dart';
import 'package:just_do_it_xplat/viewmodels/theme_viewmodel.dart';
import 'package:just_do_it_xplat/viewmodels/todo_list_viewmodel.dart';
import 'package:just_do_it_xplat/views/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => TodoModel()),
        ChangeNotifierProvider(
          create: (context) => TodoListViewModel(model: context.read()),
        ),
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),
      ],
      child: Consumer<ThemeViewModel>(
        builder: (context, state, child) {
          return MaterialApp(
            title: 'Just Do It',
            themeMode: state.themeMode,
            darkTheme: state.darkTheme,
            theme: state.lightTheme,
            home: const HomeScreen(title: 'Just Do It'),
          );
        },
      ),
    );
  }
}
