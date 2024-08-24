import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

import '../../../../data/models/stadium_model.dart';
import '../../../viewmodels/stadium_notifier.dart';



class MapScreen extends ConsumerStatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> with SingleTickerProviderStateMixin {
  final MapController controller = MapController();
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  bool _isPanelVisible = false;
  StaduimModel? _selectedStadium;
  final formatter = NumberFormat('#,###', 'en_US');

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 1), // Starts from the bottom of the screen
      end: Offset(0, 0),   // Ends at its normal position
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    controller.dispose();
    _animationController.dispose(); // Dispose the animation controller
    super.dispose();
  }

  void _togglePanel(StaduimModel? stadium) {
    setState(() {
      if (_isPanelVisible) {
        _animationController.reverse();
      } else {
        _selectedStadium = stadium; // Set the selected stadium
        _animationController.forward();
      }
      _isPanelVisible = !_isPanelVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final stadiums = ref.watch(stadiumNotifierProvider);

    return stadiums.when(
      data: (List<StaduimModel> data) {
        final locations = data.map((stadium) {
          return LatLng(stadium.longitude ?? 0.0, stadium.latitude ?? 0);
        }).toList();

        LatLngBounds? bounds;
        if (locations.isNotEmpty) {
          bounds = LatLngBounds.fromPoints(locations);
        }

        // Handle null value for pricePerHour
        final pricePerHour = _selectedStadium?.pricePerHour ?? 0;
        final formattedNumber = formatter.format(pricePerHour).replaceAll(',', ' ');

        return Stack(
          children: [
            GestureDetector(
              onTap: () {
                if (_isPanelVisible) {
                  _togglePanel(null);
                }
              },
              child: FlutterMap(
                mapController: controller,
                options: MapOptions(
                  initialCenter: bounds?.center ?? LatLng(41.311081, 69.240562),
                  initialZoom: 2,
                  minZoom: 5,
                  maxZoom: 18,
                  onMapReady: () {
                    if (bounds != null) {
                      final zoom = _calculateZoomLevel(bounds);
                      controller.move(bounds.center, zoom);
                    }
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                    additionalOptions: {
                      'accessToken': 'sk.eyJ1IjoiZG9zdG9uYmVrazI2IiwiYSI6ImNtMDR4cHJ0bzBheXEya3NnNDluMm5ueTQifQ.kviwLLs5g3ld07fVL81Ktw',
                      'id': 'mapbox/streets-v11',
                    },
                    tileSize: 256,
                    zoomOffset: 0,
                  ),
                  MarkerLayer(
                    markers: locations.asMap().entries.map((entry) {
                      int index = entry.key;
                      LatLng latLng = entry.value;
                      StaduimModel stadium = data[index];
                      return Marker(
                        point: latLng,
                        width: 42,
                        height: 48,
                        alignment: Alignment.topCenter,
                        child: InkWell(
                          onTap: () {
                            _togglePanel(stadium);
                          },
                          child: SizedBox(
                            width: 42,
                            height: 48,
                            child: SvgPicture.asset('assets/svg/map_icon.svg'),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 20,
              child: GestureDetector(
                onTap: () {
                  // Prevent closing when tapping on the panel
                },
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return SlideTransition(
                      position: _slideAnimation,
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Container(
                          height: 155,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: child,
                        ),
                      ),
                    );
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                        child: _selectedStadium?.image?.isNotEmpty == true
                            ? Image.network(
                          _selectedStadium?.image ?? '',
                          height: 155,
                          width: 140,
                          fit: BoxFit.cover,
                        )
                            : Container(
                          height: 155,
                          width: 140,
                          color: Colors.grey, // You can set a placeholder color or image here
                          child: Icon(Icons.image, color: Colors.white), // Placeholder icon
                        ),
                      ),
                      SizedBox(width: 10), // Space between elements
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _selectedStadium?.name ?? "",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF181725)),
                                maxLines: 1,
                              ),
                              SizedBox(height: 4), // Space between elements
                              Text(
                                _selectedStadium?.address ?? "",
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFFB2B2B2)),
                                maxLines: 1,
                              ),
                              SizedBox(height: 4), // Space between elements
                              Text(
                                "${formattedNumber} uzs/hour",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF2AA64C)),
                                maxLines: 1,
                              ),
                              SizedBox(height: 8), // Space between elements
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 32,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF2AA64C),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: Center(
                                      child: Text(
                                        "Book now!",
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFFFFFFFF)),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
      error: (Object error, StackTrace stackTrace) {
        return Center(child: Text("Error: $error"));
      },
      loading: () {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  double _calculateZoomLevel(LatLngBounds bounds) {
    // Placeholder function for calculating zoom level
    return 14.0;
  }
}
