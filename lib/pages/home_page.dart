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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cursos Disponibles"),
        centerTitle: true,
      ),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Explora cursos",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Aprende con rutas claras, sin distracciones",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Expanded(
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
              ),
            ],
          ),
        );
      }),
    );
  }
}
