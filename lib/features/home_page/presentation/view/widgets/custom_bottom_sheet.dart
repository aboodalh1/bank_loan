import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      height: 300,
      padding: const EdgeInsets.symmetric(
          horizontal: 20, vertical: 40),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Title must not be empty";
                }
                else
                  return null;
              },
              // controller: TitleController,
              decoration: InputDecoration(
                fillColor: Colors.grey,

                border: OutlineInputBorder(),
                label: Text('Title',
                ),
                prefixIcon: Icon(Icons.title),
              ),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 20),
            TextFormField(
                onChanged: (String value) {
                  print(value);

                },
                // controller: TimeController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Time',

                  ),
                  prefixIcon: Icon(
                      Icons.watch_later_outlined),
                ),

                keyboardType: TextInputType.datetime,
                onTap: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  ).then((value) {});

                }),
            SizedBox(height: 20),
            TextFormField(

              // controller: DateController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Date',
                  ),
                  prefixIcon: Icon(Icons.calendar_month,
                    color: Colors.grey,),
                ),
                keyboardType: TextInputType.datetime,
                onTap: () {

                  showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.parse('2030-05-30')
                  ).then((value) {

                  });

                }),
          ],
        ),
      ),
    );
  }
}
