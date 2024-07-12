import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:getx_sqflite/controller/controller.dart';

import '../../shared/custom_text_form_field.dart';

class EditScreen extends StatefulWidget {
   EditScreen({super.key, this.id, this.title, this.description, this.time});
  final int? id;
  final String? title;
  final String? description;
  final String? time;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final titleController = TextEditingController();

  final descriptionController = TextEditingController();

  final timeController = TextEditingController();

//  final controller = Get.put(SQLController());
   final SQLController controller = Get.find();

   @override
  void initState() {
    if (controller.updateTaskData) {
      titleController.text = widget.title.toString();
      timeController.text = widget.time.toString();
      descriptionController.text = widget.description.toString();
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(controller.updateTaskData ? 'Update' : 'Add'),
        centerTitle: true,
      ),
      body: Column(
        children: [
      CustomTextField(
        controller: titleController,
        validationText: 'The title must have a value  ',
        ),
      CustomTextField(
        controller: descriptionController,
        validationText: 'The description must have a value  ',
        ),
      CustomTextField(
        controller: timeController,
        validationText: 'The time must have a value  ',
        ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: MaterialButton(
          onPressed: (){
            if (!controller.updateTaskData) {
               controller.insertData(
               title: titleController.text, 
               description: descriptionController.text, 
               time: timeController.text,
              );
            }else{
              controller.updateData(
                title: titleController.text, 
               description: descriptionController.text, 
               time: timeController.text,
               id: widget.id!,
              );
            }
           
          },
          textColor: Colors.white,
          color: Colors.red,
          minWidth: double.infinity,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child:  Text(controller.updateTaskData ? 'Update' : 'Add'),
        
        ),
      )

      ],
      )

    );
  }
}