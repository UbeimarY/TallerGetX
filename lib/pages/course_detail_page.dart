import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/course_controller.dart';
import 'quiz_page.dart';

class CourseDetailPage extends StatelessWidget {
  CourseDetailPage({super.key});

  final CourseController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text("Detalle del Curso")),
      body: Obx(() {
        final course = controller.selectedCourse.value;

        if (course == null) {
          return const Center(child: Text("No hay curso seleccionado"));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colors.primary.withValues(alpha: 0.9),
                      colors.secondary.withValues(alpha: 0.9),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: colors.primary.withValues(alpha: 0.2),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.title,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: colors.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      course.description,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: colors.onPrimary),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Lecciones:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              ...List.generate(course.lessons.length, (index) {
                return Obx(() {
                  bool completed = controller.completedLessons.contains(index);
                  return Card(
                    child: CheckboxListTile(
                      title: Text(course.lessons[index]),
                      value: completed,
                      onChanged: (_) => controller.toggleLesson(index),
                    ),
                  );
                });
              }),

              const SizedBox(height: 10),

              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: controller.progress,
                  minHeight: 10,
                  backgroundColor: colors.surfaceContainerHighest,
                  color: colors.primary,
                ),
              ),

              const SizedBox(height: 5),

              Text("${(controller.progress * 100).toInt()}% completado"),

              if (controller.completedLessons.length == course.lessons.length &&
                  controller.quizCompleted.value)
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

              if (controller.completedLessons.length == course.lessons.length)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => QuizPage());
                      },
                      child: const Text("Presentar Quiz"),
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
