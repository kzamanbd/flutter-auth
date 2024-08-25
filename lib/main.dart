import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: emailController,
            style: const TextStyle(color: Colors.deepPurple),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter your email',
              labelText: 'Email',
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            style: const TextStyle(color: Colors.deepPurple),
            controller: passwordController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter your password',
              labelText: 'Password',
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    // Retrieve the text the that user has entered by using the
                    // TextEditingController.
                    content: Text(emailController.text),
                  );
                },
              );
            },
            child: const Text('Login'),
          ),
        ],
      ),
    ));
  }
}
