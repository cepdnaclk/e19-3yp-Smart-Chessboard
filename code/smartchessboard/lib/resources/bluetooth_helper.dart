import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:smartchessboard/provider/move_data_provider.dart';

class BluetoothHelper {
  FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;
  BluetoothConnection? _connection;
  List<String> messages = [];

  Future<void> initBluetooth() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetoothScan,
      Permission.bluetoothAdvertise,
      Permission.bluetoothConnect,
      Permission.bluetooth,
    ].request();

    if (statuses[Permission.bluetoothScan] == PermissionStatus.granted &&
        statuses[Permission.bluetoothAdvertise] == PermissionStatus.granted &&
        statuses[Permission.bluetoothConnect] == PermissionStatus.granted) {
      bool? isEnabled = await _bluetooth.isEnabled;
      if (isEnabled != null && isEnabled) {
        print('Bluetooth is already enabled');
        _discoverDevices();
      } else {
        await _bluetooth.requestEnable();
        _bluetooth.onStateChanged().listen((BluetoothState state) {
          print('Bluetooth State: $state');
          if (state == BluetoothState.STATE_ON) {
            _discoverDevices();
          }
        });
      }
    }
  }

  void _discoverDevices() {
    _bluetooth.getBondedDevices().then((List<BluetoothDevice> devices) {
      if (devices.isNotEmpty) {
        _connectToDevice(devices[0]);
      }
    });
  }

  void _connectToDevice(BluetoothDevice device) async {
    BluetoothConnection.toAddress(device.address).then((connection) {
      print('Connected to ${device.name}');
      _connection = connection;
      _listenForMessages();
    }).catchError((error) {
      print('Error connecting to device: $error');
    });
  }

  void _listenForMessages() {
    _connection!.input!.listen((List<int> data) {
      String jsonString = utf8.decode(data);
      print('Received JSON: $jsonString');

      try {
        dynamic decodedJson = json.decode(jsonString);
        ;
        print(decodedJson['from']);
      } catch (e) {
        print('Error decoding JSON: $e');
      }
    }).onDone(() {
      print('Connection closed');
    });
  }

  Future<void> sendMessage(Map<String, dynamic> jsonMessage) async {
    if (_connection == null || !_connection!.isConnected) {
      await initBluetooth();
    }
    if (_connection != null && _connection!.isConnected) {
      String jsonString = json.encode(jsonMessage);
      _connection!.output.add(utf8.encode(jsonString + '\n'));
      await _connection!.output.allSent; // Wait for the message to be sent
      print('Sent message: $jsonString');
    }
  }

  void dispose() {
    if (_connection != null) {
      _connection!.dispose();
    }
  }
}
