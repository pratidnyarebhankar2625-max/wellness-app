import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/theme_tokens.dart';

/// Animated circular progress ring that displays the wellness score
/// using custom shaders derived from the active theme colors.
class WellnessScoreRing extends StatefulWidget {
  final double score; // 0.0 to 1.0
  final double size;
  final String label;
  final String subtitle;

  const WellnessScoreRing({
    super.key,
    required this.score,
    this.size = 170,
    this.label = 'Wellness Score',
    this.subtitle = 'Optimal Balance',
  });

  @override
  State<WellnessScoreRing> createState() => _WellnessScoreRingState();
}

class _WellnessScoreRingState extends State<WellnessScoreRing>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant WellnessScoreRing oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.score != widget.score) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final animatedScore = widget.score * _animation.value;
        final percentage = (animatedScore * 100).round();

        return SizedBox(
          width: widget.size,
          height: widget.size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Custom circular ring painter
              CustomPaint(
                size: Size(widget.size, widget.size),
                painter: _ScoreRingPainter(
                  progress: animatedScore,
                  primaryColor: colors.primary,
                  primaryDark: colors.primaryDark,
                  accentColor: colors.accent,
                  trackColor: colors.borderLight,
                  strokeWidth: 14,
                ),
              ),

              // Inner content
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$percentage%',
                    style: textTheme.displayMedium?.copyWith(
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                      color: colors.textPrimary,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.label,
                    style: textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: colors.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      widget.subtitle,
                      style: textTheme.labelSmall?.copyWith(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w600,
                        color: colors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ScoreRingPainter extends CustomPainter {
  final double progress;
  final Color primaryColor;
  final Color primaryDark;
  final Color accentColor;
  final Color trackColor;
  final double strokeWidth;

  _ScoreRingPainter({
    required this.progress,
    required this.primaryColor,
    required this.primaryDark,
    required this.accentColor,
    required this.trackColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // 1. Background Track
    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);

    if (progress <= 0) return;

    // 2. Gradient Arc for progress
    final rect = Rect.fromCircle(center: center, radius: radius);
    final sweepGradient = SweepGradient(
      startAngle: -math.pi / 2,
      endAngle: 3 * math.pi / 2,
      colors: [primaryColor, primaryDark, accentColor, primaryColor],
      transform: const GradientRotation(-math.pi / 2),
    );

    final progressPaint = Paint()
      ..shader = sweepGradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(rect, -math.pi / 2, sweepAngle, false, progressPaint);

    // 3. Dot at the tip of the progress arc
    final tipAngle = -math.pi / 2 + sweepAngle;
    final tipCenter = Offset(
      center.dx + radius * math.cos(tipAngle),
      center.dy + radius * math.sin(tipAngle),
    );

    final dotGlow = Paint()
      ..color = primaryColor.withValues(alpha: 0.4)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(tipCenter, strokeWidth / 2 + 3, dotGlow);

    final dotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(tipCenter, strokeWidth / 2 - 2, dotPaint);
  }

  @override
  bool shouldRepaint(covariant _ScoreRingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.primaryColor != primaryColor ||
        oldDelegate.accentColor != accentColor;
  }
}
