import 'package:asset_tracker/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class AddAreaScreen extends StatefulWidget {
  const AddAreaScreen({super.key});

  @override
  State<AddAreaScreen> createState() => _AddAreaScreenState();
}

class _AddAreaScreenState extends State<AddAreaScreen> {
  void _saveArea() {
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Constants.addArea,
          style: GoogleFonts.latoTextTheme().titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
        ),
        actions: [
          IconButton(
              onPressed: _saveArea,
              icon: Icon(
                Icons.save,
                color: Colors.white,
              ))
        ],
      ),
    );
  }
}
