import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/course_controller.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final CourseController controller = Get.find();

  @override
  void initState() {
    super.initState();
    if (controller.questions.isEmpty) {
      controller.loadQuiz();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quiz Final")),
      body: Obx(() {
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.questions.length,
          itemBuilder: (context, index) {
            final colors = Theme.of(context).colorScheme;
            final question = controller.questions[index];
            final selected = controller.selectedAnswers[index];
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      question.question,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...List.generate(question.options.length, (optionIndex) {
                      final isSelected = selected == optionIndex;
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected
                                ? colors.primary
                                : colors.outlineVariant,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          title: Text(question.options[optionIndex]),
                          trailing: Icon(
                            isSelected
                                ? Icons.radio_button_checked
                                : Icons.radio_button_off,
                            color: isSelected ? colors.primary : colors.outline,
                          ),
                          onTap: () =>
                              controller.answerQuestion(index, optionIndex),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!controller.allQuestionsAnswered()) {
            Get.snackbar(
              "Faltan preguntas",
              "Por favor responde todas las preguntas antes de finalizar.",
              snackPosition: SnackPosition.BOTTOM,
            );
            return;
          }
          controller.computeScore();
          controller.markQuizCompleted();
          Get.defaultDialog(
            title: "Resultado",
            middleText:
                "Tu puntaje es ${controller.score.value} / ${controller.questions.length}",
            textCancel: "Cerrar",
            textConfirm: "Generar Certificado",
            onCancel: () => Get.back(),
            onConfirm: () {
              Get.back();
              Get.defaultDialog(
                title: "🎓 Certificado",
                middleText:
                    "¡Felicidades!\nHas completado el quiz del curso correctamente.",
                textConfirm: "Cerrar",
                onConfirm: () => Get.back(),
              );
            },
          );
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
