import 'package:flutter/material.dart';
import 'package:mindwrite/features/home_feature/domain/entities/note_model_entity.dart';

class NoteWidget extends StatefulWidget {
  final NoteModelEntity selectedNote;
  final VoidCallback onDismissed;

  const NoteWidget(
      {super.key, required this.selectedNote, required this.onDismissed});

  @override
  NoteWidgetState createState() => NoteWidgetState();
}

class NoteWidgetState extends State<NoteWidget> {
  double _opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.selectedNote.id.toString()),
      onDismissed: (direction) {
        widget.onDismissed();
      },

      child: AnimatedOpacity(
        opacity: _opacity,
        duration: const Duration(milliseconds: 300),
        child: Container(
          decoration: BoxDecoration(
            color: widget.selectedNote.noteBackground!.color,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: widget.selectedNote.noteBackground!.color ==
                      Colors.transparent
                  ? Colors.grey
                  : widget.selectedNote.noteBackground!.color,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.selectedNote.title!,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.selectedNote.description!,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
      // Detect the dismiss progress and apply fade effect
      onUpdate: (details) {
        setState(() {
          _opacity = (1.0 - (details.progress + 0.2)).clamp(0.0, 1.0);
        });
      },
    );
  }
}
