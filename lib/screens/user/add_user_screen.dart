import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constants.dart';

/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  void _saveZone() {
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Constants.addUser,
          style: GoogleFonts.latoTextTheme().titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
        ),
        actions: [
          IconButton(
              onPressed: _saveZone,
              icon: const Icon(
                Icons.save,
                color: Colors.white,
              ))
        ],
      ),
    );
  }
}
