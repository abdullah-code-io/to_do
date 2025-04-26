import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/blocs/setting/theme_bloc.dart';
import 'package:to_do/blocs/setting/theme_state.dart';
import 'package:to_do/screens/home_page.dart';
import 'package:to_do/screens/setting_page.dart';

import 'blocs/todo/todo_bloc.dart';

void main() {
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TodoBloc()),
        BlocProvider(create: (context) => ThemeBloc()),
        // add more BlocProviders if needed
      ],
      child:  MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            brightness: Brightness.light,
            scaffoldBackgroundColor: Colors.white,
            cardColor: Colors.grey[200],
          ),
          darkTheme: ThemeData(
            primarySwatch: Colors.deepPurple,
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Colors.black,
            cardColor: Colors.grey[800],
          ),
          themeMode: state.theme == AppTheme.dark ? ThemeMode.dark : ThemeMode.light,
          home: const HomePage(),
        );
      },
    );
  }
}
