import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Book UI',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Home Screen'),
        ),
        body: Row(
          children: [
            // Left Sidebar
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.grey[200],
                child: const NavigationSidebar(),
              ),
            ),
            // Center Book Text + Settings
            const Expanded(
              flex: 3,
              child: ColoredBox(
                color: Colors.white,
                child: BookText(),
              ),
            ),
            // Right Sidebar
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.grey[300],
                child: const InteractionSidebar(),
              ),
            ),
          ],
        ),
      );
}

class NavigationSidebar extends StatelessWidget {
  const NavigationSidebar({super.key});

  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.all(8),
        children: const [
          Text('Chapter:', style: TextStyle(fontWeight: FontWeight.bold)),
          ListTile(title: Text('1 - Why Flutter?')),
          ListTile(title: Text('2 - Playing Darts')),
          ListTile(title: Text('3 - Widgets')),
          ListTile(title: Text('4 - Dino Dicks')),
          SizedBox(height: 20),
          Text('Chapter Exercises:',
              style: TextStyle(fontWeight: FontWeight.bold)),
          ListTile(title: Text('Hello, Dart!')),
          ListTile(title: Text('Hello, Flutter!')),
          ListTile(title: Text('Strings')),
          ListTile(title: Text('Ints, Bools, Calc')),
          SizedBox(height: 20),
          Text('Bookmarks and Notes:',
              style: TextStyle(fontWeight: FontWeight.bold)),
          ListTile(title: Text('---')),
          ListTile(title: Text('---')),
          ListTile(title: Text('---')),
        ],
      );
}

class BookText extends StatelessWidget {
  const BookText({super.key});

  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Chapter 1: Why Flutter?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'In 2016, the company product lorem ipsum...',
              style: TextStyle(fontSize: 18),
            ),
            // Add more text content here
          ],
        ),
      );
}

class InteractionSidebar extends StatelessWidget {
  const InteractionSidebar({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Scratchpad',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.white,
                    height: 200,
                    child: const Text(
                      '10 PRINT "Hi"\n'
                      '20 GOTO 30\n'
                      '25 REM Line 25\n'
                      '30 GOTO 20',
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Output',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.white,
                    height: 100,
                    child: const Center(child: Text('Hi!')),
                  ),
                ],
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Chat',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.white,
                    height: 200,
                    child: const Text(
                      'Why so many virgins?'
                      '\n\nGreat question! Scientists have studied...',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
}
