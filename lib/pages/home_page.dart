import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/course_controller.dart';
import 'course_detail_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final CourseController controller = Get.put(CourseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cursos Disponibles"), centerTitle: true),
      body: Obx(() {
        return ListView.builder(
          itemCount: controller.courses.length,
          itemBuilder: (context, index) {
            final course = controller.courses[index];

            return ListTile(
              title: Text(course.title),
              subtitle: Text(course.description),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                controller.selectCourse(course);
                Get.to(() => CourseDetailPage());
              },
            );
          },
        );
      }),
    );
  }
}
