import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hasta_takip/Api/apiservice.dart';

import 'package:hasta_takip/PatientScreens/SymptomsPage.dart';


class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key,required this.categoryName});
  
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: ()async{
          await APIService.matchDoctors(categoryName);
          Get.to(SymptomPage(symptom: categoryName,));
        },
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.deepPurple[200],
          ),
          child: Text(categoryName,style: TextStyle(fontSize: 16),),
        ),
      ),
    );
  }
}
