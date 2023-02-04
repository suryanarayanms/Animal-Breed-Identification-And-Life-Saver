import 'package:flutter/material.dart';
import 'package:the_dog_project/Breeds/breeds.dart';
import 'package:the_dog_project/Pet%20Adoption/login_splash.dart';
import 'package:the_dog_project/Pet%20Detection/breed_detection.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(
                top: 75.0,
                left: 30,
              ),
              child: Padding(
                padding: EdgeInsets.only(bottom: 30.0),
                child: Text(
                  'The\ndog\nproject',
                  style: TextStyle(fontFamily: "BebasNeue", fontSize: 50),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30, bottom: 30),
              child: Container(
                // height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: Colors.blue.shade400),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, top: 20, bottom: 20, right: 80),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Total Breeds\navailable",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "BebasNeue",
                              fontSize: 25)),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: '120',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 90,
                            fontFamily: "BebasNeue",
                          ),
                        ),
                      ])),
                      GestureDetector(
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => Breeds())))
                        },
                        child: Container(
                          // height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color.fromARGB(255, 123, 192, 249)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, top: 10, bottom: 10),
                            child: Row(
                              children: const [
                                Text('click here to explore',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "BebasNeue",
                                        fontSize: 25)),
                                Icon(Icons.keyboard_arrow_right_outlined,
                                    color: Colors.white, size: 40),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30, bottom: 20),
              child: Text("Explore",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "BebasNeue",
                      fontSize: 40)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: GestureDetector(
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => BreedDetection())))
                      },
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            color: Colors.orange.shade400),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/dog.png',
                                height: 115,
                              ),
                              const Text("Know me",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "BebasNeue",
                                      fontSize: 30)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => {
                      // AuthService().signOut()

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => LoginSplashScreen()))),
                    },
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: Colors.pink.shade400),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/adopt.png',
                              height: 115,
                            ),
                            const Text("Adopt Me",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "BebasNeue",
                                    fontSize: 30)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
