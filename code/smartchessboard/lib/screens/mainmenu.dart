import 'package:flutter/material.dart';
import 'package:smartchessboard/screens/create_room_screen.dart';
import 'package:smartchessboard/screens/game_screen.dart';
import 'package:smartchessboard/screens/join_room_screen.dart';


class MainMenu extends StatelessWidget {

  static String routeName = '/main-menu';

  void createRoom(BuildContext context) {
    Navigator.pushNamed(context, CreateRoomScreen.routeName);
  }

  void joinRoom(BuildContext context) {
    Navigator.pushNamed(context, JoinRoomScreen.routeName);
  }

  void playGame(BuildContext context) {
    Navigator.pushNamed(context, GameScreen.routeName);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          // we will give media query height
          // double.infinity make it big as my parent allows
          // while MediaQuery make it big as per the screen

          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            // even space distribution
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "Hi!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,

                    ),
                    
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Your Move, Anywhere in the World\nSmartChess Board, Infinite Play",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 15,

                  ),)
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2.5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/mainmenubackground.png")
                  )
                ),
              ),
              Column(
                children: <Widget>[
                                    
                  MaterialButton(
                    minWidth: 250,
                    height: 60,
                    onPressed: (){
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=> SignupPage()));
                      playGame(context);

                    },
                    color: Color(0xff0095FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      
                    ),
                    child: Text(
                      "Start",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 18
                      ),
                    ),
                  ),
                  SizedBox(height:50),
                  MaterialButton(
                    minWidth:250,
                    height: 60,
                    onPressed: () {
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                      createRoom(context);

                    },
                    color: Color.fromARGB(255, 68, 68, 68),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      // side: BorderSide(
                      //   color: Colors.black
                      // ),
                    ),
                    child: Text(
                      "Create a new Room",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 15
                      ),
                    ),
                  ),
                  // creating the signup button
                  SizedBox(height:20),
                  MaterialButton(
                    minWidth: 250,
                    height: 60,
                    onPressed: (){
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=> SignupPage()));
                      joinRoom(context);

                    },
                    color: Color.fromARGB(255, 68, 68, 68),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      // side: BorderSide(
                      //   color: Colors.black
                      // ),
                    ),
                    child: Text(
                      "Join a Room",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 15
                      ),
                    ),
                  ),


                ],
              )



            ],
          ),
        ),
      ),
    );
  }
}