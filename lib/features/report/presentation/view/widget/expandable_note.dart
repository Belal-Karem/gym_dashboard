import 'package:flutter/material.dart';

class ExpandableNote extends StatefulWidget {
  final String text;

  const ExpandableNote({super.key, required this.text});

  @override
  State<ExpandableNote> createState() => _ExpandableNoteState();
}

class _ExpandableNoteState extends State<ExpandableNote> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Text(
        widget.text,
        maxLines: isExpanded ? null : 1,
        overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
