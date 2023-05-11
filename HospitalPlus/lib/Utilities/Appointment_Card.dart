import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hasta_takip/Models/UserModel.dart';
import 'package:intl/intl.dart';

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;

  const AppointmentCard({Key? key, required this.appointment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yyyy');
    final timeFormat = DateFormat('HH:mm');

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            if (appointment.syptomPicture == null) {
              return AlertDialog(
                title: Text('Fotoğraf Yok'),
                content: Text('Hastanın dosyası bulunamadı.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Tamam'),
                  ),
                ],
              );
            } else {
              return AlertDialog(
                content: Image.memory(
                  Uint8List.fromList(appointment.syptomPicture!),
                  fit: BoxFit.cover,
                ),
              );
            }
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.deepPurple[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              SizedBox(height: 8),
              Text(
                appointment.patient!.firstName! +
                    " " +
                    appointment.patient!.lastName!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text('Tarih: ${dateFormat.format(appointment.appointmentDate!)}'),
              SizedBox(height: 8),
              Text('Saat: ${timeFormat.format(appointment.appointmentDate!)}'),
              SizedBox(height: 8),
              Text(
                'Hastanın Dosyası',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
