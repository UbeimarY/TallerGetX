import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/course_controller.dart';
import '../widgets/course_card.dart';
import 'course_detail_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final CourseController controller = Get.put(CourseController());

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cursos Disponibles"),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colors.surface,
              colors.surfaceContainerHighest.withValues(alpha: 0.6),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Obx(() {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 3 / 2,
              ),
              itemCount: controller.courses.length,
              itemBuilder: (context, index) {
                final course = controller.courses[index];
                return CourseCard(
                  title: course.title,
                  subtitle: course.description,
                  onTap: () {
                    controller.selectCourse(course);
                    Get.to(() => CourseDetailPage());
                  },
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
