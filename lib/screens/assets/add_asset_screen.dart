import 'package:asset_tracker/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class AddAssetScreen extends StatefulWidget {
  const AddAssetScreen({super.key});

  @override
  State<AddAssetScreen> createState() => _AddAssetScreenState();
}

class _AddAssetScreenState extends State<AddAssetScreen> {
  void _saveZone() {
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Constants.addAsset,
          style: GoogleFonts.latoTextTheme().titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
        ),
        actions: [
          IconButton(
              onPressed: _saveZone,
              icon: Icon(
                Icons.save,
                color: Colors.white,
              ))
        ],
      ),
    );
  }
}
