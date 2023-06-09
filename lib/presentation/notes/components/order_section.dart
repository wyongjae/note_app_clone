import 'package:flutter/material.dart';
import 'package:note_app_clone/domain/util/note_order.dart';
import 'package:note_app_clone/domain/util/order_type.dart';

class OrderSection extends StatelessWidget {
  final NoteOrder noteOrder;
  final Function(NoteOrder noteOrder) onOrderChanged;

  const OrderSection({
    Key? key,
    required this.noteOrder,
    required this.onOrderChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
          child: Row(
            children: [
              SizedBox(
                width: 40,
                child: Radio<NoteOrder>(
                  value: NoteOrder.title(noteOrder.orderType),
                  groupValue: noteOrder,
                  onChanged: (NoteOrder? value) {
                    onOrderChanged(NoteOrder.title(noteOrder.orderType));
                  },
                  activeColor: Colors.white,
                ),
              ),
              const Text('Title'),
              SizedBox(
                width: 40,
                child: Radio<NoteOrder>(
                  value: NoteOrder.date(noteOrder.orderType),
                  groupValue: noteOrder,
                  onChanged: (NoteOrder? value) {
                    onOrderChanged(NoteOrder.date(noteOrder.orderType));
                  },
                  activeColor: Colors.white,
                ),
              ),
              const Text('Date'),
              SizedBox(
                width: 40,
                child: Radio<NoteOrder>(
                  value: NoteOrder.color(noteOrder.orderType),
                  groupValue: noteOrder,
                  onChanged: (NoteOrder? value) {
                    onOrderChanged(NoteOrder.color(noteOrder.orderType));
                  },
                  activeColor: Colors.white,
                ),
              ),
              const Text('Color'),
            ],
          ),
        ),
        SizedBox(
          height: 30,
          child: Row(
            children: [
              SizedBox(
                width: 40,
                child: Radio<OrderType>(
                  value: const OrderType.ascending(),
                  groupValue: noteOrder.orderType,
                  onChanged: (OrderType? value) {
                    onOrderChanged(noteOrder.copyWith(
                      orderType: const OrderType.ascending(),
                    ));
                  },
                  activeColor: Colors.white,
                ),
              ),
              const Text('Ascending'),
              SizedBox(
                width: 40,
                child: Radio<OrderType>(
                  value: const OrderType.descending(),
                  groupValue: noteOrder.orderType,
                  onChanged: (OrderType? value) {
                    onOrderChanged(noteOrder.copyWith(
                      orderType: const OrderType.descending(),
                    ));
                  },
                  activeColor: Colors.white,
                ),
              ),
              const Text('Descending'),
            ],
          ),
        )
      ],
    );
  }
}
