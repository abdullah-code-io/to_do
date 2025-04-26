import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/blocs/setting/theme_bloc.dart';
import 'package:to_do/blocs/setting/theme_event.dart';
import 'package:to_do/blocs/setting/theme_state.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeBloc>().state.theme == AppTheme.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Choose theme' ,  style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Text(isDarkMode ? 'Dark' : 'Light' , style: Theme.of(context).textTheme.bodyMedium),
                  const Spacer(),
                  Switch(
                    activeColor: Colors.grey,
                    value: isDarkMode,
                    onChanged: (value) {
                      context.read<ThemeBloc>().add(ToggleThemeEvent());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
