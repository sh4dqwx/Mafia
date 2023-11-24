import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MenuPage(),
    );
  }
}

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

  // nickname użytkownika do testów
  String nickname = "Testowy123";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0), // Odstęp od boków ekranu
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 25.0),
            Text(
                'Welcome, $nickname!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            SizedBox(height: 25.0),
            ElevatedButton(
              onPressed: () {
                /* - Przekierowanie do dołączenia do pokoju

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Menu()),
                );
                */
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width - 25.0, 60),
                textStyle: TextStyle(fontSize: 32.0),
              ),
              child: Text('Join game'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                /* - Przekierowanie do stworzenia nowego pokoju
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Menu()),
                );
                */
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 60),
                textStyle: TextStyle(fontSize: 32.0),
              ),
              child: Text('Create game'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                /* - Przekierowanie do historii gier

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Menu()),
                );
                */
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 60),
                textStyle: TextStyle(fontSize: 32.0),
              ),
              child: Text('Game history'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                /* - Przekierowanie do ustawień

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Menu()),
                );
                 */
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 60),
                textStyle: TextStyle(fontSize: 32.0),
              ),
              child: Text('Settings'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                /* - Przekierowanie do wylogowania się

                Tutaj wylogowywanie się

                */
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 60),
                textStyle: TextStyle(fontSize: 32.0),
              ),
              child: Text('Log out'),
            ),
          ],
        ),
      ),
    );
  }
}
