import 'package:get/get.dart';
import '../models/course_model.dart';
import '../models/question_model.dart';

class CourseController extends GetxController {
  var courses = <Course>[].obs;
  var selectedCourse = Rxn<Course>();
  var completedLessons = <int>[].obs;

  var questions = <Question>[].obs;
  var selectedAnswers = <int>[].obs;
  var score = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadCourses();
  }

  void loadCourses() {
    courses.addAll([
      Course(
        title: "Flutter Básico",
        description: "Aprende lo esencial de Flutter",
        lessons: [
          "¿Qué es Flutter?",
          "Widgets",
          "Layouts",
          "Navegación",
          "State Management",
        ],
      ),
      Course(
        title: "GetX desde Cero",
        description: "Manejo de estado global",
        lessons: [
          "¿Qué es GetX?",
          "Obx y .obs",
          "Controladores",
          "Navegación con Get",
        ],
      ),
    ]);
  }

  void selectCourse(Course course) {
    selectedCourse.value = course;
    completedLessons.clear();
  }

  void toggleLesson(int index) {
    if (completedLessons.contains(index)) {
      completedLessons.remove(index);
    } else {
      completedLessons.add(index);
    }
  }

  double get progress {
    if (selectedCourse.value == null) return 0.0;
    return completedLessons.length / selectedCourse.value!.lessons.length;
  }

  // =========================
  // QUIZ
  // =========================

  void loadQuiz() {
    questions.clear();
    selectedAnswers.clear();
    score.value = 0;

    questions.addAll([
      Question(
        question: "¿Qué es Flutter?",
        options: [
          "Un lenguaje",
          "Un SDK de Google",
          "Un servidor",
          "Un navegador",
        ],
        correctIndex: 1,
      ),
      Question(
        question: "¿Qué es GetX?",
        options: [
          "Base de datos",
          "Framework backend",
          "Gestor de estado",
          "Lenguaje",
        ],
        correctIndex: 2,
      ),
    ]);
  }

  void answerQuestion(int questionIndex, int selectedIndex) {
    // evitar responder dos veces la misma pregunta
    if (selectedAnswers.length > questionIndex) return;

    selectedAnswers.add(selectedIndex);

    if (questions[questionIndex].correctIndex == selectedIndex) {
      score.value++;
    }
  }
}
