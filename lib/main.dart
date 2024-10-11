import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ЭФБО-03-22 Сагайлюк Михаил",
      theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: Colors.deepOrangeAccent)),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Column(
                children: [
                  const Text("Авторизация",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.only(top: 130),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(
                                labelText: "Логин",
                                labelStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                ),
                                hintText: "ivanov@gmail.com",
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black12, width: 0),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                filled: true,
                                fillColor: const Color(0xFFF0EFF4)),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            decoration: InputDecoration(
                              labelText: "Пароль",
                              labelStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                              ),
                              hintText: "*********",
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black12, width: 0),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              filled: true,
                              fillColor: const Color(0xFFF0EFF4),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 10.0),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                            ),
                          ),
                          const RememberMeCheckbox(),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: const Color(0xFF0B6BFE),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                              ),
                              child: const Text(
                                'Войти',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: const Color(0xFF296A86),
                                  backgroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      side: const BorderSide(color: Color(0xFF638287))
                                  ),
                                ),
                                child: const Text("Регистрация",
                                  style: TextStyle(fontSize: 20),
                                )
                            ),
                          ),
                          const SizedBox(height: 15),
                          const TextButton(
                            onPressed: null,
                            child: const Text(
                              "Востановить пароль",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RememberMeCheckbox extends StatefulWidget {
  const RememberMeCheckbox({super.key});

  @override
  _RememberMeCheckboxState createState() => _RememberMeCheckboxState();
}

class _RememberMeCheckboxState extends State<RememberMeCheckbox> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: _isChecked,
          onChanged: (bool? value) {
            setState(() {
              _isChecked = value!;
            });
          },
          side: const BorderSide(
            color: Colors.grey,
            width: 2.0,
          ),
        ),
        const Text(
          'Запомнить меня',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
