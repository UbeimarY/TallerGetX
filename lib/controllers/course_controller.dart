import 'package:get/get.dart';
import 'package:global_status/models/course_model.dart';
import 'package:global_status/models/quiz_question.dart' as models;

class CourseController extends GetxController {
  var courses = <Course>[].obs;
  var selectedCourse = Rxn<Course>();
  var completedLessons = <int>[].obs;

  var questions = <models.QuizQuestion>[].obs;
  // Map: questionIndex -> selectedOptionIndex
  var selectedAnswers = <int, int>{}.obs;
  var score = 0.obs;
  var quizCompleted = false.obs;

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
      models.QuizQuestion(
        question: "¿Qué es Flutter?",
        options: [
          "Un lenguaje",
          "Un SDK de Google",
          "Un servidor",
          "Un navegador",
        ],
        correctIndex: 1,
      ),
      models.QuizQuestion(
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
    selectedAnswers[questionIndex] = selectedIndex;
  }

  void computeScore() {
    var s = 0;
    for (var i = 0; i < questions.length; i++) {
      final sel = selectedAnswers[i];
      if (sel != null && questions[i].correctIndex == sel) {
        s++;
      }
    }
    score.value = s;
  }

  bool allQuestionsAnswered() => selectedAnswers.length == questions.length;

  void markQuizCompleted() {
    quizCompleted.value = true;
  }
}
