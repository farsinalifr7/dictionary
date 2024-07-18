import 'dart:convert';

import 'package:dectionary/models/dictionary_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DictionaryModel? dictionaryModel;
  Future<DictionaryModel?> getData(String word) async {
    final url = 'https://api.dictionaryapi.dev/api/v2/entries/en/$word';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        setState(() {
          dictionaryModel = DictionaryModel.fromJson(jsonResponse[0]);
        });
        print(dictionaryModel!.meanings[0].definitions[0].definition);
        print(dictionaryModel!.meanings[0].definitions[1].definition);
        print(dictionaryModel!.meanings[0].definitions[2].definition);
        // return DictionaryModel.fromJson(jsonResponse[0]);
      } else {
        dictionaryModel = null;
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error getting data: $e');
      return null;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.person_2),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Find The",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w300),
                        ),
                        const Text(
                          " Meaning Of The Words",
                          style: TextStyle(
                              fontSize: 27, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            // onChanged: (value) => runFilter(value),
                            onSubmitted: (value) => getData(value),
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                              hintText: "Serch the word ",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ]),
                ),
              ),
            ),
          ),
          if (dictionaryModel != null)
            Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              // Text(
                              //   dictionaryModel!.word,
                              //   style: const TextStyle(
                              //       fontSize: 20, fontWeight: FontWeight.w600),
                              // ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  dictionaryModel!.word,
                                  style: GoogleFonts.lora(
                                    textStyle: const TextStyle(
                                        color: Colors.grey,
                                        wordSpacing: 2,
                                        letterSpacing: 1.5,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              if (dictionaryModel!.phonetics[0].text != null)
                                Text(dictionaryModel!.phonetics[0].text
                                    .toString()),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: dictionaryModel!.meanings.length,
                          itemBuilder: (context, index) {
                            final meaning = dictionaryModel!.meanings[index];

                            return showMeaning(meaning);
                          }),
                    )
                  ],
                )),
          if (dictionaryModel == null)
            Expanded(
              flex: 3,
              child: Container(),
            )
        ],
      ),
    );
  }

  showMeaning(Meaning meaning) {
    String wordDefinition = "";
    for (var element in meaning.definitions) {
      int index = meaning.definitions.indexOf(element);
      wordDefinition += " ${element.definition}\n";
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            //border: Border.all(color: Colors.grey),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 10,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meaning.partOfSpeech,
                  style: GoogleFonts.lora(
                    textStyle: const TextStyle(
                        color: Colors.deepPurple,
                        wordSpacing: 2,
                        letterSpacing: 1.5,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Text(wordDefinition),
                if (meaning.definitions[0].example != null)
                  Text(
                    "Example: ${meaning.definitions[0].example}",
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
