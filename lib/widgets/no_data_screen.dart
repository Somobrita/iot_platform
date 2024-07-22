import 'package:asset_tracker/resource/app_resource.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class NoDataScreen extends StatelessWidget {
  const NoDataScreen({super.key, required this.onRetry});

  final void Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Icon(
          Icons.info,
          size: 100,
          color: Colors.blue,
        ),
        const SizedBox(height: 20),
        Text(
          'No data available',
          style: GoogleFonts.latoTextTheme().titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 24,
              ),
        ),
        const SizedBox(height: 10),
        Text(
          'There is no data to display at the moment.',
          textAlign: TextAlign.center,
          style: GoogleFonts.latoTextTheme().titleLarge!.copyWith(
                fontWeight: FontWeight.normal,
                color: Colors.black,
                fontSize: 16,
              ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            onRetry();
          },
          child: Text(
            AppTexts.refresh,
            style: GoogleFonts.latoTextTheme().titleLarge!.copyWith(
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                ),
          ),
        ),
      ],
    );
  }
}
