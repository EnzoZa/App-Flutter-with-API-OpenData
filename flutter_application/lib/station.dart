import 'package:flutter/material.dart';
import 'package:flutter_application/main.dart';
import 'package:flutter_application/meteo.dart';

class StationElement {
  final from;
  final name;
  final request_name;

  StationElement(this.from, this.name, this.request_name);
}

class Stations extends StatelessWidget {
  final City city;
  Stations({Key? key, required this.city}): super(key: key);

    List<StationElement> bastia_stations = [
      StationElement('Bastia','Bastia Giraud', 'BASTIA+GIRAUD'),
      StationElement('Bastia','Bastia Montesoro', 'BASTIA+MONTESORO'),
      StationElement('Bastia','Bastia Fango', 'Bastia+Fango'),
      //StationElement('Lucciana','BASTIA+LA+MARANA'),
      //StationElement('Sarrola-Carcopino','AJACCIO+PIATANICCIA'),
      //StationElement('Venaco','Venaco'),
    ];

    List<StationElement> ajaccio_stations = [
      StationElement('Ajaccio','Ajaccio Canetto', 'AJACCIO+CANETTO'),
      StationElement('Ajaccio','Ajaccio Abbatucci', 'Ajaccio+Abbatucci'),
      StationElement('Ajaccio','Ajaccio Sposata', 'AJACCIO+SPOSATA'),
    ];

    List<StationElement> active_stations = [];

  @override
  Widget build(BuildContext context) {

    if (city.name == 'Bastia'){
      active_stations = bastia_stations;
    } else if (city.name == 'Ajaccio'){
      active_stations = ajaccio_stations;
    }

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
              'Choississez une station',
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
                children: active_stations
                    .map(
                      (e) => InkWell(
                        onTap: () {
                          var city = City(e.from, false, e.name, e.request_name);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => Meteo(city: city))
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