import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartchessboard/models/profile.dart';
import 'package:smartchessboard/provider/profile_data_provider.dart';
import 'package:smartchessboard/resources/socket_methods.dart';

class JoinCommunityScreen extends StatefulWidget {
  static String routeName = '/join-community';
  const JoinCommunityScreen({Key? key}) : super(key: key);

  @override
  State<JoinCommunityScreen> createState() => _JoinCommunityScreenState();
}

class _JoinCommunityScreenState extends State<JoinCommunityScreen> {
  final SocketMethods _socketMethods = SocketMethods();
  late PageController _pageController;
  int currentPageIndex = 0; // Added variable to track the current page

  @override
  void initState() {
    super.initState();
    _socketMethods.communityConnect();
    _socketMethods.listenCommunity(context);
    _socketMethods.communityGameAcceptorWithdraw(context);
    _socketMethods.onCommunityGameAcceptorWithdraw = run;
    _pageController = PageController(initialPage: currentPageIndex);
  }

  @override
  void dispose() {
    _socketMethods.disposeCommunitySockets();
    _pageController.dispose();
    super.dispose();
  }

  void run(String nickname, String profileId) {
    print(nickname);
    print(profileId);

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                    "${nickname}"+" has sent invitation"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      _socketMethods.communityGameAcceptorWithdrawReply(profileId, true);
                                      Navigator.of(context)
                                          .pop();
                                    },
                                    child: Text("Accept"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      _socketMethods.communityGameAcceptorWithdrawReply(profileId, false);
                                      Navigator.of(context)
                                          .pop();
                                    },
                                    child: Text("Reject"),
                                  ),
                                ],
                              );
                            },
                          );
  }

  @override
  Widget build(BuildContext context) {
    ProfileDataProvider communityDataProvider =
        Provider.of<ProfileDataProvider>(context);
    int length = communityDataProvider.onlineProfilesData!.length;
    List<Profile> onlinePlayers = communityDataProvider.onlineProfilesData!;

    return WillPopScope(
      onWillPop: () async {
        _socketMethods.communityDisconnect();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              _socketMethods.communityDisconnect();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            // Single scrollable button to switch between Online Players and Leaderboard
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _pageController.animateToPage(0,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                      setState(() {
                        currentPageIndex = 0; // Update the current page index
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: currentPageIndex == 0
                          ? Colors.grey // Change color if current page
                          : Color(0xff0095FF),
                    ),
                    child: Text(
                      "Online Players",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _pageController.animateToPage(1,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                      setState(() {
                        currentPageIndex = 1; // Update the current page index
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: currentPageIndex == 1
                          ? Colors.grey // Change color if current page
                          : Color(0xff0095FF),
                    ),
                    child: Text(
                      "Leaderboard",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            // PageView to switch between Online Players and Leaderboard
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentPageIndex = index; // Update the current page index
                  });
                },
                children: [
                  // Online Players
                  ListView.builder(
                    itemCount: length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Show a dialog box asking if the user wants to play
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                    "Play with ${onlinePlayers[index].nickname}?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      // Handle the user's choice (e.g., initiate a game)
                                      _socketMethods.askCommunityGame(
                                          onlinePlayers[index].profileId);
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                      // Add your logic to initiate a game here
                                      print(
                                          "Initiate a game with ${onlinePlayers[index].nickname}");
                                    },
                                    child: Text("Yes"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                    },
                                    child: Text("No"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: ListTile(
                          
                          tileColor: Color.fromARGB(255, 240, 240, 240),
                          title: Text(
                            '${index + 1}. ${onlinePlayers[index].nickname}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 47, 47, 47),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  // Leaderboard
                  ListView(
                    children: [
                      // ListTile(
                      //     tileColor: Color.fromARGB(255, 240, 240, 240),
                      //     title: Text("Player A - Score: 100")),
                      // Padding(padding: EdgeInsets.only(bottom: 5.0)),
                      // ListTile(
                      //     tileColor: Color.fromARGB(255, 240, 240, 240),
                      //     title: Text("Player B - Score: 90")),
                      // //Add more leaderboard items
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
