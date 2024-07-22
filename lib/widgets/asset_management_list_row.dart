import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../models/asset/asset_model.dart';
import '../resource/app_resource.dart';
import '../utils/arc_clipper.dart';

/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class AssetManagementListRow extends StatelessWidget {
  const AssetManagementListRow({super.key, required this.assetModel});

  final AssetModel assetModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5.0),
          topRight: Radius.circular(5.0),
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(5.0),
        ),
      ),
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceVariant,
      // Set the clip behavior of the card
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.all(8),
      child: Stack(
        children: [
          Center(
            child: Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(20.0)),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).colorScheme.onPrimaryContainer,
                      Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(.5),
                    ]),
              ),
              child: ClipRect(child: CustomPaint(painter: ArcClipper())),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(
                assetModel.name!,
                style: GoogleFonts.latoTextTheme().titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.background,
                      fontSize: 15,
                    ),
                textAlign: TextAlign.center,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    assetModel.idCodeValue!,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.background,
                        fontWeight: FontWeight.normal),
                  ),
                  Text(
                    // Format the datetime as needed
                    assetModel.idCodeType!,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.background,
                        fontWeight: FontWeight.normal),
                  ),
                  Text(
                    assetModel.assetTypeName!,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.background,
                        fontWeight: FontWeight.normal),
                  ),
                  Text(
                    DateFormat('MMM d, y - hh:mm a')
                        .format(DateTime.parse(assetModel.inductionDate!)),
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.background,
                        fontWeight: FontWeight.normal),
                  ),
                  if (assetModel.assetStatus == 'Enabled')
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 15.0,
                            height: 20.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.contentColorGreen,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Center(
                            child: Text(
                              assetModel.assetStatus!,
                              style: const TextStyle(
                                  color: AppColors.contentColorWhite,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    )
                  else
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        children: [
                          Container(
                            width: 20.0,
                            height: 20.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.contentColorRed,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Center(
                            child: Text(
                              assetModel.assetStatus!,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                ],
              ),
              //trailing: Icon(Icons.assessment),
              onTap: () {
                // Handle row tap here
              },
            ),
          )
        ],
      ),
    );
  }
}
