import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/course_controller.dart';

class CourseDetailPage extends StatelessWidget {
  CourseDetailPage({super.key});

  final CourseController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          final course = controller.selectedCourse.value;
          return Text(course?.title ?? "Curso");
        }),
      ),
      body: Obx(() {
        final course = controller.selectedCourse.value;

        if (course == null) {
          return const Center(child: Text("No hay curso seleccionado"));
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(course.description, style: const TextStyle(fontSize: 18)),

              const SizedBox(height: 20),

              const Text(
                "Lecciones:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              Expanded(
                child: ListView.builder(
                  itemCount: course.lessons.length,
                  itemBuilder: (context, index) {
                    return Obx(() {
                      bool completed = controller.completedLessons.contains(
                        index,
                      );

                      return CheckboxListTile(
                        title: Text(course.lessons[index]),
                        value: completed,
                        onChanged: (_) {
                          controller.toggleLesson(index);
                        },
                      );
                    });
                  },
                ),
              ),

              const SizedBox(height: 10),

              LinearProgressIndicator(value: controller.progress),

              const SizedBox(height: 5),

              Text("${(controller.progress * 100).toInt()}% completado"),

              if (controller.progress == 1.0)
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.defaultDialog(
                          title: "🎓 Certificado",
                          middleText:
                              "¡Felicidades!\nHas completado el curso correctamente.",
                          textConfirm: "Cerrar",
                          onConfirm: () => Get.back(),
                        );
                      },
                      child: const Text("Obtener Certificado"),
                    ),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
