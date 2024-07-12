import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_sqflite/controller/controller.dart';

import '../../shared/custom_text_form_field.dart';

class EditScreen extends StatelessWidget {
   EditScreen({super.key, this.id});
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final timeController = TextEditingController();
  final controller = Get.put(SQLController());
  final int? id;
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
               id: id!,
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