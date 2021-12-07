import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{

  AnimationController sizeController;
  Animation sizeAnim;

  AnimationController fadeController;
  Animation fadeAnim;

  int currentScreen = 0;

  List screens = [];

  @override
  void initState() {
    sizeController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    sizeAnim = CurvedAnimation(
        parent: sizeController, curve: Curves.easeInOutQuint);
    sizeController.addListener(() {
      setState(() {});
    });
    fadeController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    fadeAnim = CurvedAnimation(
        parent: fadeController, curve: Curves.easeInOutQuint);
    fadeController.addListener(() {
      setState(() {});
    });
    screens = [
      Container(
        color: Colors.red,
        child: Center(child: IconButton(icon: Icon(Icons.add), onPressed: () {setState(() {
          sizeController.forward();
        });})),
      ),
      Container(
        color: Colors.blue,
        child: Center(child: IconButton(icon: Icon(Icons.add), onPressed: () {setState(() {
          sizeController.forward();
        });})),
      ),
    ];
    super.initState();
  }

  @override
  void dispose() {
    sizeController.dispose();
    fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black87,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        fadeController.forward();
                        fadeAnim.addStatusListener((status){
                          currentScreen = 0;
                          fadeController.reverse();
                          sizeController.reverse();
                        });
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        fadeController.forward();
                        fadeAnim.addStatusListener((status){
                          currentScreen = 1;
                          fadeController.reverse();
                          sizeController.reverse();
                        });
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(((sizeAnim.value + (fadeAnim.value * (MediaQuery.of(context).size.height * 2))) * (MediaQuery.of(context).size.width / 2)), 0),
            child: Transform.scale(
              scale: 1 - (sizeAnim.value * 0.5),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(sizeAnim.value * 45)),
                  child: screens[currentScreen],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
