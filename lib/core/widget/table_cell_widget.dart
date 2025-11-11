import 'package:flutter/material.dart';

class TableCellWidget extends StatelessWidget {
  const TableCellWidget(
    this.text, {
    super.key,
    this.textAlign = TextAlign.center,
    this.style,
    this.padding = const EdgeInsets.symmetric(vertical: 10),
  });

  final String text;
  final TextAlign textAlign;
  final TextStyle? style;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Center(
        child: Text(
          text,
          textAlign: textAlign,
          style: style ?? const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    );
  }
}

class TableHeaderCellWidget extends StatelessWidget {
  const TableHeaderCellWidget(
    this.text, {
    super.key,
    this.textAlign = TextAlign.center,
    this.style,
    this.padding = const EdgeInsets.symmetric(vertical: 10),
  });

  final String text;
  final TextAlign textAlign;
  final TextStyle? style;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Center(
        child: Text(
          text,
          textAlign: textAlign,
          style:
              style ??
              TextStyle(
                color: Colors.white.withAlpha(150),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
