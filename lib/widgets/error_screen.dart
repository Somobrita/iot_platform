import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class ErrorScreen extends StatelessWidget {
  const ErrorScreen(
      {super.key, required this.errorMessage, required this.onRetry});

  final void Function() onRetry;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Icon(
          Icons.error,
          size: 100,
          color: Colors.red,
        ),
        const SizedBox(height: 20),
        Text(
          'An error occurred',
          style: GoogleFonts.latoTextTheme().titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 24,
              ),
        ),
        const SizedBox(height: 10),
        Text(
          'Something went wrong while performing the operation. $errorMessage',
          textAlign: TextAlign.center,
          style: GoogleFonts.latoTextTheme().titleLarge!.copyWith(
                fontWeight: FontWeight.normal,
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 16,
              ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            onRetry();
            // You can navigate back or perform some action to retry the operation here.
          },
          child: Text(
            'Retry',
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
