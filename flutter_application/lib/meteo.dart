import 'package:flutter/material.dart';
import 'package:flutter_application/main.dart';
import 'package:flutter_application/station.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Meteo extends StatefulWidget {
  final City city;
  Meteo({Key? key, required this.city}): super(key: key);

  @override
  Widget build(BuildContext context) {
    var text = Text('Meteo ' + city.name + ' ' + city.station_name);
    
    return Scaffold(
      appBar: AppBar(
        title: text, 
      ),
    );
  }
  
  @override
  State<Meteo> createState() => _MeteoState();
}

class _MeteoState extends State<Meteo> {
  var wheather_informations = [];

  @override
  initState() {
    refreshWeathers();
    super.initState();
  } 

  Future refreshWeathers () async {
    var url = 'https://www.data.corsica/api/records/1.0/search/?dataset=query-outfields-and-where-1-3d1-and-f-geojson&q=&facet=nom_dept&facet=nom_com&facet=nom_station&facet=x_l93&facet=y_l93&refine.nom_com='+widget.city.name+'&refine.nom_station='+widget.city.station_request_name+'&timezone=Europe%2FParis&rows=1&format=json&lang=fr';
    Uri uri = Uri.parse(url);

    final response = await http.get(uri);
    var data = json.decode(response.body);
    data = data['records'];
    print(data);
    this.wheather_informations = [];
    setState(() {
      for(var i = 0; i < data.length; i++){
        this.wheather_informations.add(data[i]);
        print(data[i]);
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
   var text = Text('Meteo ' + widget.city.name + ' ' + widget.city.station_name);
    
    return Scaffold(
      appBar: AppBar(
        title: text, 
      ), 
      body: RefreshIndicator(
        onRefresh: refreshWeathers,
        child: ListView.builder(
          itemCount: wheather_informations.length,
          itemBuilder: (context, index){
            return ListTile(title : Text(wheather_informations[index]['fields']['nom_station'])); //${wheather_informations[index]}['fields']['nom_station']
          }),
      )
    );
  } 

}