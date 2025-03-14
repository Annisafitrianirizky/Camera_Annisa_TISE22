import 'package:camera_annisa_tise22/widget/filter_selector.dart';
import 'package:flutter/material.dart';
import 'dart:io';


@immutable
class HasilFilter extends StatefulWidget {
  final String imagePath;

  const HasilFilter({super.key, required this.imagePath});


  @override
  State<HasilFilter> createState() => _HasilFilterState();
}


class _HasilFilterState extends State<HasilFilter> {
  final _filters = [
    Colors.white,
    ...List.generate(
      Colors.primaries.length,
      (index) => Colors.primaries[(index * 4) % Colors.primaries.length],
    )
  ];


  final _filterColor = ValueNotifier<Color>(Colors.white);


  void _onFilterChanged(Color value) {
    _filterColor.value = value;
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Stack(
        children: [
          Positioned.fill(
            child: _buildPhotoWithFilter(),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: //Image.file(File(imagePath)),
            _buildFilterSelector(),
          ),
        ],
      ),
    );
  }


  Widget _buildPhotoWithFilter() {
    return ValueListenableBuilder(
      valueListenable: _filterColor,
      builder: (context, color, child) {
        // Anda bisa ganti dengan foto Anda sendiri
        return widget.imagePath.isNotEmpty
        ? Image.file(File(widget.imagePath),
         // color: color.withOpacity(0.5),
         color:color.withValues(alpha: 0.5),
          colorBlendMode: BlendMode.color,
          //fit: BoxFit.cover,
        )
        : const SizedBox();
      },
    );
  }


  Widget _buildFilterSelector() {
    return FilterSelector(
      onFilterChanged: _onFilterChanged,
      filters: _filters,
    );
  }
}
