import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class SubmitButton extends StatelessWidget {
  const SubmitButton(
      {super.key, required this.submitText, required this.onSubmitClick});

  final String submitText;
  final void Function() onSubmitClick;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        onSubmitClick();
      },
      child: Text(
        submitText,
        style: GoogleFonts.latoTextTheme().titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
              fontSize: 14,
            ),
      ),
    );
  }
}
