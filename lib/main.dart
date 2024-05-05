import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_svg/flutter_svg.dart';

String generateUniqueId() {
  var uuid = Uuid();
  return uuid.v4();
}

class On_Off_Scene extends StatefulWidget {
  final String code;
  final bool isActivated;
  final Function(bool) onChanged; // Callback function

  On_Off_Scene(
      {required this.code, required this.isActivated, required this.onChanged});

  @override
  State<On_Off_Scene> createState() => _On_Off_SceneState();
}

class _On_Off_SceneState extends State<On_Off_Scene> {
  late bool _isOn;

  @override
  void initState() {
    super.initState();
    _isOn = widget.isActivated;
  }

  void _toggleState() {
    setState(() {
      _isOn = !_isOn;
    });
    widget.onChanged(_isOn);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 1.5, // Adjust the scale factor as needed
          child: Switch(
            value: _isOn,
            onChanged: (newValue) {
              _toggleState();
            },
            activeColor: const Color(0xFFA58BFF),
            inactiveThumbColor: const Color(0xFFFAF7FF),
            inactiveTrackColor: Colors.black.withOpacity(0.2),
          ),
        ),
      ],
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isSwitchOn = false; // Track the state of the switch

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFFFFFAFA),
          padding: const EdgeInsets.fromLTRB(16, 120, 1, 145),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(1, 0, 1, 112),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Smart Light',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                      height: 1.4,
                      letterSpacing: 0.4,
                      color: const Color(0xFF000000),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 181.3),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(15, 60, 0, 0),
                            child: On_Off_Scene(
                              code: 'YourCodeHere',
                              isActivated: true,
                              onChanged: (bool value) {
                                setState(() {
                                  _isSwitchOn = value;
                                });
                              },
                            ),
                          ),
                          Container(
                            width: 170.77,
                            height: 180.69,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('lib/Images/s-l640 1.png'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_isSwitchOn) // Conditionally render the image based on switch state
                      Positioned(
                        right: 15,
                        bottom: -120,
                        child: Opacity(
                          opacity: 0.5,
                          child: SizedBox(
                            width: 143,
                            height: 121,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                      'lib/Images/vector_246_x2.png'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: 239,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFA58BFF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(
                              16.8,
                              10.5,
                              16.8,
                              10.5,
                            ),
                            child: Text(
                              'Delete',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                height: 1,
                                letterSpacing: 0.1,
                                color: const Color(0xFFFFFAFA),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF6900FF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.5,
                              horizontal: 20,
                            ),
                            child: Text(
                              'Save',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                height: 1,
                                letterSpacing: 0.1,
                                color: const Color(0xFFFFFAFA),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}
