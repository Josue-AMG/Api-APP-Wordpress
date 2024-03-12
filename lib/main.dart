// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const Cuerpo());
}

class Cuerpo extends StatelessWidget {
  const Cuerpo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Api_APP',
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(backgroundColor: Color.fromARGB(255, 144, 12, 12) ,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(FontAwesomeIcons.toolbox,color: Colors.grey,)),
              Tab(icon: Icon(FontAwesomeIcons.male,color: Colors.grey)),
              Tab(icon: Icon(FontAwesomeIcons.calendar,color: Colors.grey)),
              Tab(icon: Icon(FontAwesomeIcons.university,color: Colors.grey)),
              Tab(icon: Icon(FontAwesomeIcons.cloud,color: Colors.grey)),
              Tab(icon: Icon(FontAwesomeIcons.wordpress,color: Colors.grey)),
              Tab(icon: Icon(FontAwesomeIcons.info,color: Colors.grey)),
            ],
          ),
          title: Center(child:Text('API TOOLBOX APP') ,) ,
        ),
        body: TabBarView(
          children: [
              TapCaja(),
              Predecir_Genero(),
              Predecir_Edad(),
              UniversidadesxPais(),
              Clima(),
              PaginaWordPress(),
              Acerca_de(),
          ],
        ),
      ),
    );
  }
}


class TapCaja extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
     
      body: Center(
        child: Column(
          
          children:[
          Container(height: 70,width: 500,color: Color.fromARGB(255, 255, 174, 0), child: Center(child: Text('INICIO', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontSize: 50),),) ),
          
            const Text(
              'Bienvenido a la Aplicación API TOOLBOX APP',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 20.0),
            Image.asset(
              'assets/Images/toolbox.png', 
              width: 500.0,
              height: 500.0,
            ),
          ],
        ),
      ),
    );
  }
}

class Predecir_Genero extends StatefulWidget {
  @override
  _Predecir_GeneroState createState() => _Predecir_GeneroState();
}

class _Predecir_GeneroState extends State<Predecir_Genero> {
   TextEditingController _nameController = TextEditingController();
  String _gender = '';
  Color _backgroundColor = Colors.white;

  void predictGender(String name) async {
    String apiUrl = 'https://api.genderize.io/?name=$name';
    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        _gender = data['gender'];
        _backgroundColor =
            _gender.toLowerCase() == 'male' ? Colors.blue : Colors.pink;
      });
    } else {
      setState(() {
        _gender = '';
        _backgroundColor = Colors.white;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
     
      body: Center(
        child: Column(
          
          children:[
          Container(height: 70,width: 500,color: Color.fromARGB(255, 255, 174, 0), child: Center(child: Text('PREDECIR GENERO', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontSize: 40),),) ),
          
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Escribe tu nombre',
                
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                predictGender(_nameController.text);
              },
              child: Text('Predecir de genero'),
            ),
            SizedBox(height: 20.0),
            _gender.isNotEmpty
                ? Text(
                    'Prediccion de Genero: $_gender',
                    style: TextStyle(fontSize: 20.0),
                  )
                : Container(),
            SizedBox(height: 20.0),
            Container(
              width: 200.0,
              height: 200.0,
              color: _backgroundColor,
            ),
          ],
        ),
      ),
    );
  }
}


class Predecir_Edad extends StatefulWidget {
  @override
  _Predecir_EdadState createState() => _Predecir_EdadState();
}

class _Predecir_EdadState extends State<Predecir_Edad> {
    TextEditingController _nameController = TextEditingController();
  int _age = 0;
  String _ageGroup = '';
  String _imagePath = '';

  void determineAge(String name) async {
    String apiUrl = 'https://api.agify.io/?name=$name';
    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        _age = data['age'];
        if (_age < 30) {
          _ageGroup = 'young';
          _imagePath = 'assets/Images/young.jpg';
        } else if (_age < 60 && _age > 30) {
          _ageGroup = 'adult';
          _imagePath = 'assets/Images/adults.png';
        } else {
          _ageGroup = 'elderly';
          _imagePath = 'assets/Images/viejos.jpg';
        }
      });
    } else {
      setState(() {
        _age = 0;
        _ageGroup = '';
        _imagePath = '';
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
     
      body: Center(
        child: Column(
          
          children:[
          Container(height: 70,width: 500,color: Color.fromARGB(255, 255, 174, 0), child: Center(child: Text('PREDECIR EDAD', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontSize: 40),),) ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Escribe tu nombre',
                
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                determineAge(_nameController.text);
              },
              child: Text('Determinar Edad'),
            ),
            SizedBox(height: 20.0),
            _age > 0
                ? Column(
                    children: [
                      Text(
                        'Edad: $_age',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        '$_ageGroup',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      SizedBox(height: 10.0),
                      _imagePath.isNotEmpty
                          ? Image.asset(
                              _imagePath,
                              width: 150.0,
                              height: 150.0,
                            )
                          : Container(),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}


class UniversidadesxPais extends StatefulWidget {
  @override
  _UniversidadesxPaisState createState() => _UniversidadesxPaisState();
}

class _UniversidadesxPaisState extends State<UniversidadesxPais> {
  TextEditingController _countryController = TextEditingController();
  List<dynamic> _universities = [];

  void searchUniversities(String country) async {
    String apiUrl = 'http://universities.hipolabs.com/search?country=$country';
    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        _universities = data;
      });
    } else {
      setState(() {
        _universities = [];
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
     
      body: Center(
        child: Column(
          
          children:[
          Container(height: 70,width: 500,color: Color.fromARGB(255, 255, 174, 0), child: Center(child: Text('UNIVERSIDAD x PAIS', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontSize: 40),),) ),
            TextField(
              controller: _countryController,
              decoration: InputDecoration(
                labelText: 'Ingrese el nombre de el pais (en Ingles)',

              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                searchUniversities(_countryController.text);
              },
              child: Text('Buscar Universidades'),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: _universities.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(_universities[index]['name']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Dominio: ${_universities[index]['domains'][0]}'),
                          Text('Sitio Web: ${_universities[index]['web_pages'][0]}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class Clima extends StatefulWidget {
  @override
  _ClimaState createState() => _ClimaState();
}


class _ClimaState extends State<Clima> {
  String _weather = '';

Future<void> fetchWeather() async {
  String apiKey = '5801df1c08f1efd544766d42167c31d7';
  String apiUrl = 'http://api.openweathermap.org/data/2.5/weather?q=Santo%20Domingo,DO&appid=$apiKey&units=metric';

  var response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    double temperature = data['main']['temp'];
    String description = data['weather'][0]['description'];
    setState(() {
      _weather = 'Temperature: $temperature°C, Description: $description';
    });
  } else {
    setState(() {
      _weather = 'Failed to fetch weather data';
    });
  }
}

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
     
      body: Center(
        child: Column(
          
          children:[
          Container(height: 70,width: 500,color: Color.fromARGB(255, 255, 174, 0), child: Center(child: Text('CLIMA', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontSize: 50),),) ),

            const SizedBox(height: 20.0),
            Text(
          _weather,
          style: TextStyle(fontSize: 20.0),
        ),
          ],
        ),
      ),
    );
  }
}



class PaginaWordPress extends StatefulWidget {
  @override
  _PaginaWordPressState createState() => _PaginaWordPressState();
}



class _PaginaWordPressState extends State<PaginaWordPress> {
List<dynamic> _posts = [];

  Future<void> fetchWordPressPosts() async {
    String apiUrl = 'https://telenoticias.com.do/wp-json/wp/v2/posts';
    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        _posts = data;
      });
    } else {
      setState(() {
        _posts = [];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWordPressPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
     
      body: Center(
        child: Column(
          
          children:[
          Container(height: 70,width: 500,color: Color.fromARGB(255, 255, 174, 0), child: Center(child: Text('PAGINA WORDPRESS', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontSize: 40),),) ),

Container(
            height: 100,
            color: Colors.blue, 
            child: Center(
              child: Image.network('https://telenoticias.com.do/wp-content/uploads/2023/12/logoinicioq.png'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _posts.length > 3 ? 3 : _posts.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    String postUrl = _posts[index]['link'];
                    if (await canLaunch(postUrl)) {
                      await launch(postUrl);
                    } else {
                      print('No se puede abrir la URL');
                    }
                  },

                  child: Card(
                    margin: EdgeInsets.all(8),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _posts[index]['title']['rendered'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            _posts[index]['excerpt']['rendered'],
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                                                ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ));

  }
}


class Acerca_de extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
     
      body: Center(
        child: Column(
          
          children:[
          Container(height: 70,width: 500,color: Color.fromARGB(255, 255, 174, 0), child: Center(child: Text('ACERCA DE', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontSize: 50),),) ),
            Text(" "),
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/Images/yo.png'), // Reemplaza 'your_photo.jpg' con la ruta de tu foto
            ),
            SizedBox(height: 20),
            Text(
              'Josue Alberto Moreno Guzman',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Software Developer 👨🏿‍💻',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Información de Contacto',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Correo Electrónico: josuealbertomorenoguzman@gmail.com',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              'Teléfono: 829-844-4114',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
