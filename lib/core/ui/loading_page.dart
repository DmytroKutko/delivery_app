import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Platform.isAndroid
            ? const CircularProgressIndicator(
                color: Colors.teal,
              )
            : const CupertinoActivityIndicator(
                color: Colors.teal,
                radius: 20.0,
              ),
      ),
    );
  }
}
