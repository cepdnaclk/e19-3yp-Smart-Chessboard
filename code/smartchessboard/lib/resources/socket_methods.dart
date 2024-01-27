import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartchessboard/provider/profile_data_provider.dart';
import 'package:smartchessboard/provider/move_data_provider.dart';
import 'package:smartchessboard/provider/room_data_provider.dart';
import 'package:smartchessboard/resources/socket_client.dart';
import 'package:smartchessboard/screens/game_screen.dart';
import 'package:smartchessboard/screens/main_menu.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;
  Function? onCommunityGameAcceptorWithdraw;

  //game-screen
  void listenChessMoves(BuildContext context) {
    _socketClient.on('chessMove', (data) {
      Provider.of<MoveDataProvider>(context, listen: false)
          .updateMoveData(data);
    });
  }

  void sendChessMove(String from, String to, String? pieceToPromoteTo,
      String roomId, String nextPlayer, String whoUpdate) {
    _socketClient.emit('chessMove', {
      'roomId': roomId,
      'from': from,
      'to': to,
      'pieceToPromoteTo': pieceToPromoteTo,
      'nextPlayer': nextPlayer,
      'whoUpdate': whoUpdate,
    });
  }

  void gameDisconnect() {
    _socketClient.emit('gameDisconnect', {});
  }

  void disposeChessMoveSockets() {
    _socketClient.off('chessMove');
  }

  //community screen

  void listenCommunity(BuildContext context) {
    _socketClient.on('community', (data) {
      Provider.of<ProfileDataProvider>(context, listen: false)
          .updateOnlineProfilesData(data);
    });
  }

  void askCommunityGame(String profileId) {
    _socketClient.emit('askCommunityGame', {"profileId": profileId});
  }

  void communityGameAcceptorWithdraw(BuildContext context) {
    _socketClient.on('communityGameAcceptorWithdraw', (data) {
      if (onCommunityGameAcceptorWithdraw != null) {
        onCommunityGameAcceptorWithdraw!(data["profileId"]);
      }
    });
  }

  void disposeCommunitySockets() {
    _socketClient.off('community');
  }

  void communityConnect() {
    _socketClient.emit('communityConnect');
  }

  void communityDisconnect() {
    _socketClient.emit('communityDisconnect');
  }

  //game-menu-screen
  void createOrJoinRoom() {
    _socketClient.emit("createOrJoinRoom", {
      'nickname': "online",
    });
  }

  void joinRoomSuccessListener(BuildContext context) {
    _socketClient.on('joinRoomSuccess', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  void disposeCrateJoinSockets() {
    _socketClient.off('joinRoomSuccess');
  }

  void gameMenuDisconnect() {
    _socketClient.emit('gameMenuDisconnect');
  }

  //login screen
  void login(String email, String password) {
    _socketClient.emit("login", {'email': email, 'password': password});
  }

  void loginListener(BuildContext context) {
    _socketClient.on('loginSuccess', (data) {
      // print(data);
      Provider.of<ProfileDataProvider>(context, listen: false)
          .updateMyProfile(data);
      _socketClient.off('loginSuccess');
      Navigator.pushNamedAndRemoveUntil(
        context,
        MainMenu.routeName,
        (route) => false,
      );
    });
  }

  //signup screen
  void signup(
      String nickname, String email, String password, String confirmPassword) {
    if (password == confirmPassword) {
      _socketClient.emit("signup",
          {'nickname': nickname, 'email': email, 'password': password});
    }
  }

  void signupListener(BuildContext context) {
    _socketClient.on('signupSuccess', (data) {
      Provider.of<ProfileDataProvider>(context, listen: false)
          .updateMyProfile(data);
      _socketClient.off('signupSuccess');
      Navigator.pushNamedAndRemoveUntil(
        context,
        MainMenu.routeName,
        (route) => false,
      );
    });
  }
}
