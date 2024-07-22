import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../models/asset/asset_model.dart';
import '../../provider/api_data_provider.dart';
import '../../widgets/error_screen.dart';
import '../../widgets/no_data_screen.dart';
import '../full_screen_image.dart';

/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class TrackAreaScreen extends ConsumerStatefulWidget {
  const TrackAreaScreen({super.key});

  @override
  ConsumerState<TrackAreaScreen> createState() => _TrackAreaScreenState();
}

class _TrackAreaScreenState extends ConsumerState<TrackAreaScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(assetListProvider);
  }

  @override
  void dispose() {
    super.dispose();
    ref.read(assetModelStateProvider.notifier).state = null;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final assetData = ref.watch(assetListProvider);
    AssetModel? selectedValue = ref.watch(assetModelStateProvider);
    print('selectedValue $selectedValue');
    final assetById = ref.watch(assetByIdProvider(selectedValue?.id));
    return assetData.when(
      data: (data) {
        List<AssetModel> assetList = data.map((e) => e).toList();
        if (assetList.isEmpty) {
          return Container(
            alignment: Alignment.center,
            child: NoDataScreen(onRetry: () {}),
          );
        }
        if (assetList.isEmpty) {
          return Container(
            alignment: Alignment.center,
            child: NoDataScreen(onRetry: () {}),
          );
        }
        return Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              DropdownButtonFormField<AssetModel>(
                //hint: const Text("Select Area"),
                value: selectedValue,
                decoration: InputDecoration(
                  labelText: 'Select asset',
                  hintText: 'Please choose asset',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10), gapPadding: 5),
                ),
                onChanged: (AssetModel? value) {
                  ref.read(assetModelStateProvider.notifier).state = value;
                  ref.invalidate(assetByIdProvider);
                  ref.read(assetByIdProvider(selectedValue?.id));
                },
                items: assetList
                    .map(
                      (AssetModel cate) => DropdownMenuItem<AssetModel>(
                        value: cate,
                        child: Row(
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer, // Border color
                                  width: 2.0, // Border width
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 20, // Adjust the radius as needed
                                //backgroundImage: NetworkImage(cate.image!),
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(cate.name!,
                                style: GoogleFonts.latoTextTheme()
                                    .titleLarge!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground))
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(
                height: 10,
              ),
              if (selectedValue != null)
                assetById.when(
                  data: (data) {
                    return Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              data.areaName!,
                              style: GoogleFonts.latoTextTheme()
                                  .titleLarge!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              data.zoneName!.mapValue!.values.toString(),
                              style: GoogleFonts.latoTextTheme()
                                  .titleLarge!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            /*SizedBox(
                              child: CustomPaint(
                                // Adjust the size as needed

                                painter: ImagePainter(
                                    screenSize: screenSize,
                                    imageUrl: snapshot.data!.areaImage!,
                                    points: _pointList,
                                    zoneAreas: snapshot.data!.zoneAreas!),
                                size: screenSize,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),*/
                            if (data.areaImage!.isEmpty ||
                                data.areaImage == null)
                              Image.asset(
                                  'assets/images/no-image-icon-23504.png')
                            else
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (BuildContext context,
                                          Animation<double> animation,
                                          Animation<double>
                                              secondaryAnimation) {
                                        print(data.areaImage!);
                                        if (data.areaImage!.isEmpty ||
                                            data.areaImage == null) {
                                          return FullScreenPage(
                                            dark: true,
                                            child: Image.asset(
                                                'assets/images/no-image-icon-23504.png'),
                                          );
                                        }
                                        return FullScreenPage(
                                          dark: true,
                                          child: Image.network(
                                            data.areaImage!,
                                          ),
                                        );
                                      },
                                      transitionDuration:
                                          const Duration(milliseconds: 500),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        var begin = 0.0;
                                        var end = 1.0;
                                        var curve = Curves.ease;

                                        var tween = Tween(
                                                begin: begin, end: end)
                                            .chain(CurveTween(curve: curve));
                                        return ScaleTransition(
                                          scale: animation.drive(tween),
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Image.network(
                                  data.areaImage!,
                                ),
                              )
                          ],
                        ),
                      ),
                    );
                  },
                  error: (error, stackTrace) {
                    return Center(
                      child: ErrorScreen(
                          errorMessage: error.toString(), onRetry: () {}),
                    );
                  },
                  loading: () {
                    return Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.blueAccent,
                        size: 70,
                      ),
                    );
                  },
                ),
            ],
          ),
        );
      },
      error: (error, stackTrace) {
        return Center(
          child: ErrorScreen(errorMessage: error.toString(), onRetry: () {}),
        );
      },
      loading: () {
        return Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
            color: Colors.blueAccent,
            size: 70,
          ),
        );
      },
    );
  }
}
