import 'package:api/theme.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'API app',
      home: StartPage(),
    );
  }
}

class MyPage extends StatefulWidget {
  const MyPage({super.key, required this.lat, required this.lon});

  final String lat;
  final String lon;

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  dynamic data;

  @override
  void initState() {
    super.initState();
    setState(() {
      read();
    });
  }

  Future<void> read() async {
    Dio dio = Dio();
    dio.options.headers["X-Yandex-API-Key"] =
        '425e7140-c801-4b2f-8eb1-c2f14fc4b358';
    final response = await dio.get(
        'https://api.weather.yandex.ru/v2/forecast?lat=${widget.lat}&lon=${widget.lon}&lang=ru_RU&limit=2&extra=true&lang=ru_RU');

    if (response.statusCode == 200) {
      setState(() {
        data = response.data;
      });
    } else {
      throw Exception('Failed to load weather');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: thirdColor,
        title: const Text('Яндекс.Погода'),
      ),
      body: Column(
        children: [
          data != null
              ? Expanded(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 15,
                      child: Center(
                        child: Text(
                          '${data['geo_object']['locality']['name']}',
                          style: const TextStyle(
                            color: thirdColor,
                            fontSize: 26,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '${data["fact"]["temp"]}°',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 80,
                                ),
                              ),
                              Text(
                                'Ощущается как: ${data["fact"]["feels_like"]}°',
                                style: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child: FaIcon(
                                      FontAwesomeIcons.wind,
                                      color: thirdColor,
                                      size: 16,
                                    ),
                                  ),
                                  Text(
                                      style: const TextStyle(
                                        color: Colors.white54,
                                        fontSize: 18,
                                      ),
                                      '${data["fact"]["wind_speed"]}м/с'),
                                ],
                              ),
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child: FaIcon(
                                      FontAwesomeIcons.temperatureFull,
                                      color: thirdColor,
                                      size: 16,
                                    ),
                                  ),
                                  Text(
                                      style: const TextStyle(
                                        color: Colors.white54,
                                        fontSize: 18,
                                      ),
                                      '${data["fact"]["pressure_mm"]}мм рт.ст.'),
                                ],
                              ),
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child: FaIcon(
                                      FontAwesomeIcons.droplet,
                                      color: thirdColor,
                                      size: 16,
                                    ),
                                  ),
                                  Text(
                                      style: const TextStyle(
                                        color: Colors.white54,
                                        fontSize: 18,
                                      ),
                                      '${data["fact"]["humidity"]}%'),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 38,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Text(
                                    'ЫЫЫЫ',
                                    style: TextStyle(
                                        fontSize: 20, color: primaryColor),
                                  ),
                                  Text(
                                    'Ночь',
                                    style: TextStyle(
                                        fontSize: 20, color: thirdColor),
                                  ),
                                  Text(
                                    'Утро',
                                    style: TextStyle(
                                        fontSize: 20, color: thirdColor),
                                  ),
                                  Text(
                                    'День',
                                    style: TextStyle(
                                        fontSize: 20, color: thirdColor),
                                  ),
                                  Text(
                                    'Вечер',
                                    style: TextStyle(
                                        fontSize: 20, color: thirdColor),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: Container(
                                  height: 1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  color: Colors.white54,
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                'Max.',
                                style:
                                    TextStyle(fontSize: 20, color: thirdColor),
                              ),
                              Text(
                                '${data["forecasts"][0]["parts"]["night"]["temp_max"]}°',
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white70),
                              ),
                              Text(
                                '${data["forecasts"][0]["parts"]["morning"]["temp_max"]}°',
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white70),
                              ),
                              Text(
                                '${data["forecasts"][0]["parts"]["day"]["temp_max"]}°',
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white70),
                              ),
                              Text(
                                '${data["forecasts"][0]["parts"]["evening"]["temp_max"]}°',
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white70),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                'Min. ',
                                style:
                                    TextStyle(fontSize: 20, color: thirdColor),
                              ),
                              Text(
                                '${data["forecasts"][0]["parts"]["night"]["temp_min"]}°',
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white70),
                              ),
                              Text(
                                '${data["forecasts"][0]["parts"]["morning"]["temp_min"]}°',
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white70),
                              ),
                              Text(
                                '${data["forecasts"][0]["parts"]["day"]["temp_min"]}°',
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white70),
                              ),
                              Text(
                                '${data["forecasts"][0]["parts"]["evening"]["temp_min"]}°',
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white70),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ))
              : const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
        ],
      ),
    );
  }
}

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPage();
}

class _StartPage extends State<StartPage> {
  final _controller = TextEditingController();
  final _controller2 = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  String? get _errorText {
    final text = _controller.value.text;
    if (text == '') {
      return 'Поле не должно быть пустым';
    } else {
      return null;
    }
  }

  String? get _errorText2 {
    final text = _controller2.value.text;
    if (text == '') {
      return 'Поле не должно быть пустым';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          backgroundColor: thirdColor,
          title: const Text('Яднекс.Погода'),
        ),
        backgroundColor: primaryColor,
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                onChanged: null,
                controller: _controller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: secondaryColor,
                  errorText: _errorText,
                  border: const OutlineInputBorder(),
                  labelText: 'Введите широту',
                  labelStyle: const TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
                  ),
                ),
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(

                onChanged: null,
                controller: _controller2,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: secondaryColor,
                  errorText: _errorText2,
                  border: const OutlineInputBorder(),
                  labelText: 'Введите долготу',
                  labelStyle:  const TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
                  ),
                ),
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: thirdColor),
                  onPressed: () {
                    if (_controller.value.text != '' &&
                        _controller2.value.text != '') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyPage(
                                lat: _controller.value.text,
                                lon: _controller2.value.text)),
                      );
                    }
                  },
                  child: const Text('Показать прогноз')),
            )
          ],
        ));
  }
}
