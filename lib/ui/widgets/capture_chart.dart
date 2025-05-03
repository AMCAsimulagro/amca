import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class ChartCaptureWidget extends StatefulWidget {
  final Widget chart;
  final void Function(Uint8List bytes) onCaptured;

  const ChartCaptureWidget(
      {required this.chart, required this.onCaptured, Key? key})
      : super(key: key);

  @override
  State<ChartCaptureWidget> createState() => _ChartCaptureWidgetState();
}

class _ChartCaptureWidgetState extends State<ChartCaptureWidget> {
  final GlobalKey repaintKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    // Esperar al próximo frame para capturar
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        final boundary = repaintKey.currentContext!.findRenderObject()
            as RenderRepaintBoundary;

        // Esperar una pequeña duración también ayuda en algunos casos
        await Future.delayed(const Duration(milliseconds: 100));

        final image = await boundary.toImage(pixelRatio: 3.0);
        final byteData = await image.toByteData(format: ImageByteFormat.png);
        final bytes = byteData!.buffer.asUint8List();

        widget.onCaptured(bytes);
      } catch (e) {
        print('Error al capturar gráfico: $e');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: repaintKey,
      child: widget.chart,
    );
  }
}
