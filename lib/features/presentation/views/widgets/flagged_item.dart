import 'package:flutter/material.dart';
import 'package:stopwatch_app/features/data/models/marked_item_model.dart';

class FlaggedItem extends StatelessWidget {
  const FlaggedItem({super.key, required this.markedItemModel});

  final MarkedItemModel markedItemModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(right: 15.0, left: 15, top: 18, bottom: 10),
      child: Container(
        width: double.infinity,
        decoration: ShapeDecoration(
          color: Colors.grey.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Icon(
                      Icons.flag,
                      color: Color(0xff0a697a),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      markedItemModel.num.toString(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Text(
                  markedItemModel.finalTime,
                ),
              ),
              Expanded(
                child: Text(
                  markedItemModel.differenceTime,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
