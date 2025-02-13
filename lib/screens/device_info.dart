import 'dart:async';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class DeviceInfoScreen extends StatefulWidget {
  const DeviceInfoScreen({super.key});

  @override
  State<DeviceInfoScreen> createState() => _DeviceInfoScreenState();
}

class _DeviceInfoScreenState extends State<DeviceInfoScreen> {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  @override
  void initState() {
    super.initState();
    fetchDeviceInfo();
  }

  Future<void> fetchDeviceInfo() async {
    try {
      if (defaultTargetPlatform == TargetPlatform.android) {
        var info = await deviceInfoPlugin.androidInfo;
        setState(() {
          _deviceData = {
            'Brand': info.brand,
            'Model': info.model,
            'Device': info.device,
            'Manufacturer': info.manufacturer,
            'Android Version': info.version.release,
            'SDK': info.version.sdkInt,
          };
        });
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        var info = await deviceInfoPlugin.iosInfo;
        setState(() {
          _deviceData = {
            'Device': info.name,
            'System': info.systemName,
            'Version': info.systemVersion,
            'Model': info.model,
            'Identifier': info.identifierForVendor,
          };
        });
      } else {
        setState(() {
          _deviceData = {'Error': 'Unsupported platform'};
        });
      }
    } on PlatformException {
      setState(() {
        _deviceData = {'Error': 'Failed to get device info'};
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Device Info')),
        body: ListView(
          children: _deviceData.entries.map((entry) {
            return ListTile(
              title: Text(entry.key),
              subtitle: Text('${entry.value}'),
            );
          }).toList(),
        ),
      ),
    );
  }
}
