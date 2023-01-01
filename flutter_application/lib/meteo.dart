import 'package:flutter/material.dart';
import 'package:flutter_application/main.dart';
import 'package:flutter_application/station.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class Meteo extends StatefulWidget {
  final City city;
  Meteo({Key? key, required this.city}): super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Container();
  }
  
  @override
  State<Meteo> createState() => _MeteoState();
}

class _MeteoState extends State<Meteo> {
  var wheather_informations = [];
  Map<DateTime, int> date_informations = {};

  @override
  initState() {
    refreshWeathers();
    super.initState();
  } 

  Future refreshWeathers () async {
    var url = 'https://www.data.corsica/api/records/1.0/search/?dataset=query-outfields-and-where-1-3d1-and-f-geojson&q=&rows=-1&sort=date_debut&facet=nom_dept&facet=nom_com&facet=nom_station&facet=x_l93&facet=y_l93&refine.nom_com='+widget.city.name+'&refine.nom_station='+widget.city.station_request_name;
    //+'&timezone=Europe%2FParis&rows=1&format=json&lang=fr';
    Uri uri = Uri.parse(url);
    print(uri);

    final response = await http.get(uri);
    var data = json.decode(response.body);
    //print(data);
    data = data['records'];
    this.wheather_informations = [];
    this.date_informations = {};
    var valeur = 0;
    setState(() {
      for(var i = 0; i < data.length; i++){
         this.wheather_informations.add(data[i]);
        //add data[i]['date_debut'], check if it's not already in the list
        //if date_debut is not in the list, add it with his valeur data[i]['valeur']
        //else add the new value valeur data[i]['valeur'] to the existing one
        var temp_date = data[i]['fields']['date_debut'];
        temp_date = temp_date.substring(0,10);
        DateTime date = DateTime.parse(temp_date);
        valeur = double.parse(data[i]['fields']['valeur']).round();
        //print('Date: $date');
        if(this.date_informations.containsKey(date))
          // ignore: curly_braces_in_flow_control_structures
          this.date_informations.update(date, (value) => value + valeur);
        else
          this.date_informations[date] = valeur;
        
        //print(valeur);

       //print(data[i]['geometry']['coordinates']);
      }

        //print(this.date_informations);
    });
  }
  
  @override
  Widget build(BuildContext context) {
   //var text = Text('Meteo ' + widget.city.name + ' ' + widget.city.station_name);
    
    return HeatMap(
            datasets: this.date_informations,
            //startDate: date_informations.keys.first,
            //endDate: date_informations.keys.last,
            colorMode: ColorMode.opacity,
            showText: false,
            scrollable: true,
            colorsets: {
              1: Colors.red,
              3: Colors.orange,
              5: Colors.yellow,
              7: Colors.green,
              9: Colors.blue,
              11: Colors.indigo,
              13: Colors.purple,
              22: Colors.pink,
            },
          );
    /*
    Scaffold(
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
    */
  } 

}