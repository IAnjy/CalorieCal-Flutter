// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Ihinana sa iandry laoka ? xD'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int calorieBase = 0;
  int calorieAvecActivite = 0;
  int radioSelectionnee = 1;
  bool genre = false;
  double poids = 0.0;
  double age = 0;
  double taille = 170.0;
  // Map mapActivite = {"Faible": 0, "Modere": 1, "Forte": 2};

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: setColor(),
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              texteAvecStyle(
                  "Remplissez tous les champs pour obtenir votre besoin journalier en calories"), // Text
              padding(),
              Card(
                elevation: 10.0,
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    padding(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        texteAvecStyle("Femme", color: Colors.pink),
                        Switch(
                            value: genre,
                            inactiveTrackColor: Colors.pink,
                            activeTrackColor: Colors.blue,
                            onChanged: (bool b) {
                              setState(() {
                                genre = b;
                              });
                            }),
                        texteAvecStyle("Homme", color: Colors.blue),
                      ],
                    ),
                    padding(),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: setColor()),
                        // color: setColor(),
                        child: texteAvecStyle(
                            (age == 0)
                                ? "Appuyez pour entrer votre age"
                                : "Votre age est de : ${age.toInt()}",
                            color: Colors.white),
                        onPressed: (() => {montrerPicker()})),
                    padding(),
                    texteAvecStyle(
                      "Votre taille est de ${taille.toInt()} cm",
                      color: setColor(),
                    ), // text Taille
                    padding(),
                    Slider(
                      value: taille,
                      activeColor: setColor(),
                      onChanged: (double d) {
                        setState(() {
                          taille = d;
                        });
                      },
                      max: 215.0,
                      min: 100.0,
                    ),
                    padding(),
                    TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (String string) {
                        setState(() {
                          poids = double.parse(string);
                        });
                      },
                      decoration: InputDecoration(
                          labelText: "Entrez votre poids en kilos."),
                    ),
                    padding(),
                    texteAvecStyle("Quelle est votre activité sportive?",
                        color: setColor()),
                    padding(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Radio(
                              activeColor: setColor(),
                              value: 0,
                              groupValue: radioSelectionnee,
                              onChanged: (value) {
                                String zavatra = value.toString();
                                int zavatraa = int.parse(zavatra);
                                setState(() {
                                  radioSelectionnee = zavatraa;
                                });
                              },
                            ),
                            texteAvecStyle("Faible", color: setColor())
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Radio(
                              activeColor: setColor(),
                              value: 1,
                              groupValue: radioSelectionnee,
                              onChanged: (value) {
                                String zavatra = value.toString();
                                int zavatraa = int.parse(zavatra);
                                setState(() {
                                  radioSelectionnee = zavatraa;
                                });
                                // radioSelectionnee = value.toInt()
                              },
                            ),
                            texteAvecStyle("Modéré", color: setColor())
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Radio(
                              activeColor: setColor(),
                              value: 2,
                              groupValue: radioSelectionnee,
                              onChanged: (value) {
                                String zavatra = value.toString();
                                int zavatraa = int.parse(zavatra);
                                setState(() {
                                  radioSelectionnee = zavatraa;
                                });
                              },
                            ),
                            texteAvecStyle("Forte", color: setColor())
                          ],
                        ),
                      ],
                    ),

                    padding()
                  ],
                ),
              ),
              padding(),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: setColor()),
                  onPressed: CalculerNombreDeCalories,
                  child: texteAvecStyle("Calculer",
                      color: Colors.white, fontSize: 18.0))
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> montrerPicker() async {
    DateTime? choix = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.year);

    // print(choix);

    if (choix != null) {
      var difference = DateTime.now().difference(choix);
      var jours = difference.inDays;
      var ans = (jours / 365);
      setState(() {
        age = ans;
      });
    }
  }

  Padding padding() {
    return Padding(padding: EdgeInsets.only(top: 15.0));
  }

  Color setColor() {
    if (genre) {
      return Colors.blue;
    } else {
      return Colors.pink;
    }
  }

  Text texteAvecStyle(String data, {color = Colors.black, fontSize = 15.0}) {
    return Text(
      data,
      textAlign: TextAlign.center,
      style: TextStyle(color: color, fontSize: fontSize),
    );
  }

  void CalculerNombreDeCalories() {
    if (age != 0 && poids != 0) {
      //calculer
      if (genre) {
        calorieBase =
            (66.4730 + (13.7516 * poids) + (5.003 * taille) - (6.7550 * age))
                .toInt();
      } else {
        calorieBase =
            (655.8955 + (9.5634 * poids) + (1.8496 * taille) - (4.6756 * age))
                .toInt();
      }
      switch (radioSelectionnee) {
        case 0:
          calorieAvecActivite = (calorieBase * 1.2).toInt();
          break;
        case 1:
          calorieAvecActivite = (calorieBase * 1.5).toInt();
          break;
        case 2:
          calorieAvecActivite = (calorieBase * 1.8).toInt();
          break;
        default:
          calorieAvecActivite = calorieBase;
          break;
      }
      setState(() {
        dialogue();
      });
    } else {
      //alerte pas tous les champs
      alerte();
    }
  }

  Future<Null> dialogue() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext) {
          return SimpleDialog(
            title:
                texteAvecStyle("Votre besoin en calories", color: setColor()),
            contentPadding: EdgeInsets.all(15.0),
            children: [
              padding(),
              texteAvecStyle(
                  "Votre besoin de base est de : $calorieBase calories"),
              padding(),
              texteAvecStyle(
                  "Votre besoin avec activité sportive est de : $calorieAvecActivite calories"),
              padding(),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: setColor()),
                  onPressed: () {
                    Navigator.pop(buildContext);
                  },
                  child: texteAvecStyle("OK", color: Colors.white))
            ],
          );
        });
  }

  Future<Null> alerte() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            title: texteAvecStyle("Erreur"),
            content: texteAvecStyle("Tous les champs ne sont pas remplis"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(buildContext);
                  },
                  child: texteAvecStyle("OK", color: Colors.red))
            ],
          );
        });
  }

  // Row rowRadio() {
  //   List<Widget> l = [];
  //   mapActivite.forEach((key, value) {
  //     Column colonne = Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Radio(
  //           activeColor: setColor(),
  //           value: value,
  //           groupValue: radioSelectionnee,
  //           onChanged: (value) {
  //             String zavatra = value.toString();
  //             int zavatraa = int.parse(zavatra);
  //             setState(() {
  //               radioSelectionnee = zavatraa;
  //             });
  //           },
  //         ),
  //         texteAvecStyle(key, color: setColor())
  //       ],
  //     );
  //     l.add(colonne);
  //   });
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //     children: l,
  //   );
  // }

}
