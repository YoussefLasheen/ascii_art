import 'dart:io';

import 'package:ascii_art/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:enough_ascii_art/enough_ascii_art.dart' as art;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String string = '';
  String figletFont = 'cosmic.flf';
  double fontSize = 12;
  int letterSpacing = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      labelText: 'Text',
                    ),
                    onChanged: (String value) {
                      setState(() {
                        string = value;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                DropdownButton<String>(
                  underline: const SizedBox.shrink(),
                  value: figletFont,
                  items: [
                    for (final font in figlet_fonts)
                      DropdownMenuItem<String>(
                        value: font,
                        child: Text(
                            (font as String).substring(0, font.length - 4)),
                      ),
                  ],
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() {
                        figletFont = value;
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: CupertinoScrollbar(
                thumbVisibility: true,
                thickness: 10,
                thicknessWhileDragging: 10,
                child: Container(
                  constraints: const BoxConstraints(
                    minWidth: 300,
                  ),
                  decoration: ShapeDecoration(
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: const BorderSide(
                        width: 1,
                      ),
                    ),
                  ),
                  child: SingleChildScrollView(
                    primary: true,
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FutureBuilder<String>(
                        future: File('assets/figlet_fonts/$figletFont')
                            .readAsString(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return SelectableText(
                              art.renderFiglet(
                                string.split('').join(' ' * letterSpacing),
                                art.Font.text(
                                  snapshot.data!,
                                ),
                                direction:
                                    art.FigletRenderDirection.leftToRight,
                              ),
                              style: TextStyle(
                                fontSize: fontSize,
                                fontFamily: 'agave',
                              ),
                              textWidthBasis: TextWidthBasis.parent,
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                const Text('Font size:'),
                Expanded(
                  child: Slider(
                    value: fontSize.toDouble(),
                    min: 8,
                    max: 20,
                    divisions: 12,
                    label: fontSize.toString(),
                    onChanged: (double value) {
                      setState(() {
                        fontSize = value;
                      });
                    },
                  ),
                ),
                const Text('Letter spacing:'),
                Expanded(
                  child: Slider(
                    value: letterSpacing.toDouble(),
                    min: 0,
                    max: 10,
                    divisions: 10,
                    label: letterSpacing.toString(),
                    onChanged: (double value) {
                      setState(() {
                        letterSpacing = value.toInt();
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
