import 'package:flutter/material.dart';

/// Palet & helper layout bersama supaya seluruh halaman konsisten.
const Color kRed = Color(0xFFD31124);
const Color kBg = Color(0xFF0D0E11);
const Color kSurface = Color(0xFF14161C);
const Color kSurfaceAlt = Color(0xFF101217);
const Color kBorder = Color(0xFF22252E);
const Color kTextMuted = Color(0xFF8F95A5);
const Color kTextSoft = Color(0xFFC4C8D4);
const Color kWhatsApp = Color(0xFF25D366);
const Color kWarning = Color(0xFFFFA502);
const Color kSuccess = Color(0xFF2ED573);

const double kMaxContentWidth = 1180;
const double kNavBreakpoint = 980; // di bawah ini nav jadi menu
const double kNarrowBreakpoint = 720; // di bawah ini layout 1 kolom

bool isNarrow(BuildContext context) =>
    MediaQuery.sizeOf(context).width < kNarrowBreakpoint;

bool isCompactNav(BuildContext context) =>
    MediaQuery.sizeOf(context).width < kNavBreakpoint;

/// Padding horizontal halaman: rapat di mobile, dan konten dipusatkan
/// maksimal [kMaxContentWidth] di layar lebar.
double pagePadding(BuildContext context) {
  final width = MediaQuery.sizeOf(context).width;
  final side = (width - kMaxContentWidth) / 2;
  if (side > 32) return side;
  return width < kNarrowBreakpoint ? 20 : 32;
}

/// Pembungkus konten dengan lebar maksimal & padding responsif.
class ContentBox extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const ContentBox({
    super.key,
    required this.child,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    final h = isNarrow(context) ? 20.0 : 32.0;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: h),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: kMaxContentWidth),
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}

/// Judul section: eyebrow merah kecil + judul besar + subjudul opsional.
class SectionHeader extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String? subtitle;

  const SectionHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 3, height: 14, color: kRed),
            const SizedBox(width: 8),
            Text(
              eyebrow,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 2.0,
                color: kRed,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: isNarrow(context) ? 22 : 28,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
            color: Colors.white,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 6),
          Text(
            subtitle!,
            style: const TextStyle(fontSize: 13, color: kTextMuted, height: 1.5),
          ),
        ],
      ],
    );
  }
}

/// Badge logo "GR" merah.
class GrBadge extends StatelessWidget {
  final double fontSize;
  const GrBadge({super.key, this.fontSize = 14});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: fontSize * 0.6, vertical: fontSize * 0.28),
      decoration: BoxDecoration(
        color: kRed,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        'GR',
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.5,
          color: Colors.white,
        ),
      ),
    );
  }
}