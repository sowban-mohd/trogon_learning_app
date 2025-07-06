import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trogan_learning_app/features/modules/controller/modules_cubit.dart';
import 'package:trogan_learning_app/features/subjects/controller/subjects_cubit.dart';
import 'package:trogan_learning_app/features/videos/controller/video_cubit.dart';
import 'package:trogan_learning_app/init_dependencies.dart';
import 'package:trogan_learning_app/features/subjects/presentation/screens/subjects_page.dart';

void main() {
  initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<SubjectsCubit>()),
        BlocProvider(create: (_) => serviceLocator<ModulesCubit>()),
        BlocProvider(create: (_) => serviceLocator<VideoCubit>()),
      ],
      child: const LearningApp(),
    ),
  );
}

class LearningApp extends StatelessWidget {
  const LearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learning App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        cardColor: Colors.grey[900],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
      ),
      home: SubjectsPage(),
    );
  }
}
