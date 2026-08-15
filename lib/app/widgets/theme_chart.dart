import 'package:flutter/material.dart';
import '../theme/theme_tokens.dart';

/// Theme-adaptive Area / Line chart that dynamically uses the active theme palette.
class ThemeAreaChart extends StatelessWidget {
  final List<double> dataPoints; // Values from 0.0 to 100.0
  final List<String> labels;
  final double height;
  final String title;
  final String metricUnit;

  const ThemeAreaChart({
    super.key,
    required this.dataPoints,
    required this.labels,
    this.height = 180,
    this.title = '7-Day Wellness Trend',
    this.metricUnit = '%',
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: colors.textPrimary,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: colors.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Avg: ${(dataPoints.reduce((a, b) => a + b) / dataPoints.length).round()}$metricUnit',
                style: textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: colors.textPrimary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: height,
          child: CustomPaint(
            size: Size.infinite,
            painter: _AreaChartPainter(
              data: dataPoints,
              palette: colors.chartPalette,
              primaryColor: colors.primary,
              accentColor: colors.accent,
              gridColor: colors.borderLight,
              textColor: colors.textMuted,
              labels: labels,
            ),
          ),
        ),
      ],
    );
  }
}

class _AreaChartPainter extends CustomPainter {
  final List<double> data;
  final List<Color> palette;
  final Color primaryColor;
  final Color accentColor;
  final Color gridColor;
  final Color textColor;
  final List<String> labels;

  _AreaChartPainter({
    required this.data,
    required this.palette,
    required this.primaryColor,
    required this.accentColor,
    required this.gridColor,
    required this.textColor,
    required this.labels,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final bottomPadding = 24.0;
    final topPadding = 12.0;
    final chartHeight = size.height - bottomPadding - topPadding;
    final chartWidth = size.width;

    final maxVal = 100.0;
    final minVal = 0.0;
    final stepX = chartWidth / (data.length - 1);

    // 1. Draw horizontal subtle grid lines
    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1;

    for (int i = 0; i <= 4; i++) {
      final y = topPadding + chartHeight * (i / 4);
      canvas.drawLine(Offset(0, y), Offset(chartWidth, y), gridPaint);
    }

    // 2. Build smooth curve path
    final points = <Offset>[];
    for (int i = 0; i < data.length; i++) {
      final normalized = (data[i] - minVal) / (maxVal - minVal);
      final x = i * stepX;
      final y = topPadding + chartHeight * (1.0 - normalized);
      points.add(Offset(x, y));
    }

    final linePath = Path();
    linePath.moveTo(points.first.dx, points.first.dy);

    for (int i = 0; i < points.length - 1; i++) {
      final p0 = points[i];
      final p1 = points[i + 1];
      final controlX1 = p0.dx + (p1.dx - p0.dx) / 2;
      final controlY1 = p0.dy;
      final controlX2 = p0.dx + (p1.dx - p0.dx) / 2;
      final controlY2 = p1.dy;

      linePath.cubicTo(controlX1, controlY1, controlX2, controlY2, p1.dx, p1.dy);
    }

    // 3. Fill Gradient Area
    final fillPath = Path.from(linePath);
    fillPath.lineTo(chartWidth, topPadding + chartHeight);
    fillPath.lineTo(0, topPadding + chartHeight);
    fillPath.close();

    final fillGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        primaryColor.withValues(alpha: 0.35),
        primaryColor.withValues(alpha: 0.02),
      ],
    );

    final fillPaint = Paint()
      ..shader = fillGradient.createShader(
        Rect.fromLTWH(0, topPadding, chartWidth, chartHeight),
      )
      ..style = PaintingStyle.fill;

    canvas.drawPath(fillPath, fillPaint);

    // 4. Stroke Line
    final strokePaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(linePath, strokePaint);

    // 5. Data dots and labels
    final dotPaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.fill;

    final dotInnerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final textStyle = TextStyle(
      color: textColor,
      fontSize: 10,
      fontWeight: FontWeight.w600,
    );

    for (int i = 0; i < points.length; i++) {
      final p = points[i];

      // Draw dot
      canvas.drawCircle(p, 5, dotPaint);
      canvas.drawCircle(p, 2.5, dotInnerPaint);

      // Draw X-axis label
      if (i < labels.length) {
        final textSpan = TextSpan(text: labels[i], style: textStyle);
        final textPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        final textX = (p.dx - textPainter.width / 2).clamp(0.0, chartWidth - textPainter.width);
        textPainter.paint(canvas, Offset(textX, size.height - textPainter.height));
      }
    }
  }

  @override
  bool shouldRepaint(covariant _AreaChartPainter oldDelegate) {
    return oldDelegate.data != data ||
        oldDelegate.primaryColor != primaryColor ||
        oldDelegate.accentColor != accentColor;
  }
}

/// Theme-adaptive Bar Chart for habit completion / water intake trends.
class ThemeBarChart extends StatelessWidget {
  final List<double> values; // 0.0 to 1.0
  final List<String> labels;
  final double height;
  final String title;

  const ThemeBarChart({
    super.key,
    required this.values,
    required this.labels,
    this.height = 140,
    this.title = 'Weekly Routine Consistency',
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: colors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(values.length, (index) {
              final val = values[index].clamp(0.0, 1.0);
              final isHighest = val >= 0.85;

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${(val * 100).round()}%',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: isHighest ? colors.textPrimary : colors.textMuted,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: 22,
                            height: (height - 36) * (val == 0 ? 0.05 : val),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: isHighest
                                    ? [colors.accent, colors.primary]
                                    : [colors.primary, colors.primary.withValues(alpha: 0.5)],
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        labels[index],
                        style: TextStyle(
                          fontSize: 10.5,
                          fontWeight: isHighest ? FontWeight.w700 : FontWeight.w500,
                          color: isHighest ? colors.textPrimary : colors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
