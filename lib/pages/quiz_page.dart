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
            final question = controller.questions[index];
            final selected = controller.selectedAnswers[index];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  question.question,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ...List.generate(question.options.length, (optionIndex) {
                  return RadioListTile<int>(
                    title: Text(question.options[optionIndex]),
                    value: optionIndex,
                    groupValue: selected,
                    onChanged: (val) {
                      if (val != null) {
                        controller.answerQuestion(index, val);
                      }
                    },
                  );
                }),
                const Divider(),
              ],
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
