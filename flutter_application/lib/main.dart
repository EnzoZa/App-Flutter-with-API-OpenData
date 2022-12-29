import 'package:flutter/material.dart';
import 'package:flutter_application/meteo.dart';
import 'package:flutter_application/station.dart';

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
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class City {
  final name;
  final redirection;
  final station_name;
  final station_request_name;

  City(this.name, this.redirection, this.station_name, this.station_request_name);
}

class _MyHomePageState extends State<MyHomePage> {
  List<City> cities = [
    City('Bastia', true, '', ''),
    City('Ajaccio', true, '', ''),
    City('Lucciana', false, 'Bastia La Marana', 'BASTIA+LA+MARANA'),
    City('Sarrola-Carcopino', false, 'Ajaccio Piataniccia', 'AJACCIO+PIATANICCIA'),
    City('Venaco', false, 'Venaco', 'Venaco')
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f7f9),
      appBar: AppBar(
        title: Text('Flutter App Enzo Zampaglione'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Choississez une ville',
              style: TextStyle(
                fontSize: 30,
                color: Colors.black54,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                children: cities
                    .map(
                      (e) => InkWell(
                        onTap: () {
                          if (e.redirection)
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => Stations(city: e))
                            );
                          else
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => Meteo(city: e))
                          );
                        },
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(height: 10),
                              Text(
                                e.name,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}