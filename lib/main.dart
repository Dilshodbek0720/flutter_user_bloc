import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_user_bloc/blocs/users_bloc.dart';
import 'package:flutter_user_bloc/ui/users/users_screen.dart';
import 'blocs/users_event.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) => UsersBloc())
    ], child: const MainApp());
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  @override
  void initState() {
    BlocProvider.of<UsersBloc>(context).add(GetUsers());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UsersScreen()
    );
  }
}
