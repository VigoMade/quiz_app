import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/question_summary.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen(
      {super.key, required this.selectedAnswer, required this.onRestart});

  final List<String> selectedAnswer;
  final void Function() onRestart;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];
    for (var i = 0; i < selectedAnswer.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': selectedAnswer[i],
      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    final numCorrectAnswers = summaryData.where((data) {
      return data['user_answer'] == data['correct_answer'];
    }).length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Udah bener $numTotalQuestions dari $numCorrectAnswers Cihuyyyyy!',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 21,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            QuestionSummary(summaryData: getSummaryData()),
            const SizedBox(
              height: 20,
            ),
            OutlinedButton.icon(
              onPressed: onRestart,
              label: Text(
                'Mulai Ulang Kuis',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                ),
              ),
              icon: const Icon(
                Icons.restart_alt,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
