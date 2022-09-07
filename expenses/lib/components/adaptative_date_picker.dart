import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdaptativeDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateChanged;

  const AdaptativeDatePicker({required this.selectedDate, required this.onDateChanged});

  _showDatePicker(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }

      onDateChanged(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? SizedBox(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              minimumDate: DateTime(2022),
              maximumDate: DateTime.now(),
              onDateTimeChanged: onDateChanged,
            ),
          )
        : (SizedBox(
            height: 70,
            child: Row(children: <Widget>[
              Expanded(
                child: Text(selectedDate == null
                    ? 'Nenhuma data selecionada!'
                    : 'Data selecionada: ${DateFormat('dd/MM/y').format(selectedDate)}'),
              ),
              TextButton(
                  onPressed: () => _showDatePicker(context),
                  child: const Text('Selecionar Data',
                      style: TextStyle(fontWeight: FontWeight.bold)))
            ]),
          ));
  }
}
