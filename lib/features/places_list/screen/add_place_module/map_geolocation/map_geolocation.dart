import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

/// Пикер местоположения на карте.
class MapPicker extends StatefulWidget {
  final VoidCallback onCancel;
  final ValueChanged<Map<String, double>> onDone;

  const MapPicker({
    required this.onDone,
    required this.onCancel,
    Key? key,
  }) : super(key: key);

  @override
  State<MapPicker> createState() => _MapPickerState();
}

class _MapPickerState extends State<MapPicker> {
  LatLng? _position;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Expanded(
          child: FlutterMap(
            options: MapOptions(
              center: LatLng(55.5807481, 36.8251304),
              zoom: 8,
              minZoom: 4,
              maxZoom: 18,
              interactiveFlags: InteractiveFlag.all - InteractiveFlag.rotate,
              onTap: (_, pos) {
                setState(() {
                  _position = pos;
                });
              },
            ),
            children: [
              TileLayerWidget(
                options: TileLayerOptions(
                  urlTemplate:
                      'https://cartodb-basemaps-{s}.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                  fastReplace: true,
                ),
              ),
              MarkerLayerWidget(
                options: MarkerLayerOptions(
                  markers: [
                    if (_position != null)
                      Marker(
                        width: 24.0,
                        height: 24.0,
                        point: _position!,
                        builder: (ctx) => ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: const SizedBox(
                            width: 16,
                            height: 16,
                            child: ColoredBox(color: Colors.green),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: widget.onCancel,
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: _position != null
                      ? () => widget.onDone({
                            'lng': _position!.longitude,
                            'lat': _position!.latitude,
                          })
                      : null,
                  child: const Text('Choose'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
