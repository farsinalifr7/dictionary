import 'package:dectionary/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 180,
            ),
            Image.asset(
                "asset/images/girl-reading-book-outdoor-learning-female-read-and-relax-on-books-pile-isolated-student-person-study-in-library-college-vector-concept-2GEHA2G-removebg-preview.png"),
            const SizedBox(
              height: 30,
            ),
            Text(
              'The perfect language companion',
              style: GoogleFonts.lora(
                textStyle: const TextStyle(
                    color: Colors.black,
                    wordSpacing: 2,
                    letterSpacing: 1.5,
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Learn a new word every day with 'Word of the Day'",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Unlock the power of words. Define anything, learn every day'",
              style: TextStyle(color: Colors.grey),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ));
                },
                child: Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            colors: [Colors.deepPurple, Colors.white])),
                    child: const Center(
                      child: Text(
                        "Get Started  >>>",
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
