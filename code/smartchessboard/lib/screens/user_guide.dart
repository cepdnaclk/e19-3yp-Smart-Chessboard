import 'package:flutter/material.dart';

class UserGuide extends StatelessWidget {
  static String routeName = '/user-guide';
  const UserGuide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text("Chess Game User Guide",style: TextStyle(color: Colors.red),),
        // backgroundColor: Color.fromARGB(255, 88, 189, 230), // Thematic color
        flexibleSpace: Image.asset("assets/appbar2.png", fit: BoxFit.cover,
            ),
        shadowColor: Color.fromARGB(255, 11, 11, 11),
        // bottom:
        //       const TabBar(
        //       tabs: [
        //         Tab(icon: Icon(Icons.directions_car), text: ("Tab1"),),
        //         Tab(icon: Icon(Icons.directions_transit)),
        //         Tab(icon: Icon(Icons.directions_bike)),
        //       ],
        //     ),
        elevation: 100.0,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to the Chess Game User Guide! ♟️',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 6, 6, 6), // Thematic color
                ),
              ),
              SizedBox(height: 16),
              UserGuideSection(
                title: 'Overview',
                content: StyledContent_1(),
              ),
              UserGuideSection(
                title: 'Getting Started',
                content: StyledContent_2(),
              ),
              UserGuideSection(
                title: 'Basic Gameplay',
                content: Text(
                  'Making moves on the virtual board\nSyncing moves with the physical chessboard\nUnderstanding feedback and notifications',
                ),
              ),
              UserGuideSection(
                title: 'Bluetooth Connectivity',
                content: Text(
                  'Troubleshooting connection issues\nReconnecting your chessboard\nTips for optimal Bluetooth performance',
                ),
              ),
              UserGuideSection(
                title: 'App Features',
                content: Text(
                  'Exploring different game modes\nCustomizing the chessboard appearance\nAccessing game history and saved games',
                ),
              ),
              UserGuideSection(
                title: 'In-Game Assistance',
                content: Text(
                  'Utilizing hints and analysis tools\nAdjusting difficulty levels\nResuming interrupted games',
                ),
              ),
              // UserGuideSection(
              //   title: 'Flutter App Integration',
              //   content: Text(
              //     'Navigating through the app\'s various screens\nAccessing additional resources and settings\nProviding feedback and support',
              //   ),
              // ),
              UserGuideSection(
                title: 'Chessboard Maintenance',
                content: Text(
                  'Cleaning and caring for your real chessboard\nBattery management for Bluetooth connectivity\nStorage and travel tips',
                ),
              ),
              UserGuideSection(
                title: 'Frequently Asked Questions',
                content: Text(
                  'Answers to common queries\nTroubleshooting tips\nContacting our support team',
                ),
              ),
              SizedBox(height: 16),
              Text(
                'We\'re thrilled to have you on board, ready to explore the world of chess with our innovative app. Whether you\'re a seasoned player or just starting, this guide is designed to enhance your experience and make every move on the chessboard a memorable one. Happy playing!\n\nFor additional assistance or feedback, visit our website or contact our support team.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserGuideSection extends StatelessWidget {
  final String title;
  final Widget content;

  const UserGuideSection({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ),
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: content,
        ),
      ],
    );
  }
}

// ignore: camel_case_types
class StyledContent_1 extends StatelessWidget {
  const StyledContent_1({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        children: [
          TextSpan(
            text: 'Congratulations on choosing our chess app, ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 189, 47, 8),
            ),
          ),
          TextSpan(
            text: 'where the timeless game of strategy meets cutting-edge technology. ',
            style: TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
              color: Colors.black87,
            ),
          ),
          TextSpan(
            text: 'We\'ve taken chess to the next level by connecting it to a real chessboard through Bluetooth, ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.black87,
            ),
          ),
          TextSpan(
            text: 'providing you with a seamless and immersive experience. ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          TextSpan(
            text: 'To make the most out of your chess journey, we\'ve created this user guide to help you navigate through the features and enjoy every move on and off the board.',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class StyledContent_2 extends StatelessWidget {
  const StyledContent_2({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        children: [
          TextSpan(
            text: 'Connecting the app via bluetooth \n\n',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 189, 47, 8),
            ),
          ),
          TextSpan(
            text: 'where the timeless game of strategy meets cutting-edge technology. \n',
            style: TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
              color: Colors.black87,
            ),
          ),
          TextSpan(
            text: 'Setting the mobile app for the first time \n\n',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 189, 47, 8),
            ),
          ),
          TextSpan(
            text: 'We\'ve taken chess to the next level by connecting it to a real chessboard through Bluetooth, \n',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.black87,
            ),
          ),
          TextSpan(
            text: 'Quick move through app \n\n',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 189, 47, 8),
            ),
          ),
          TextSpan(
            text: 'To make the most out of your chess journey, we\'ve created this user guide to help you navigate through the features and enjoy every move on and off the board.',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}