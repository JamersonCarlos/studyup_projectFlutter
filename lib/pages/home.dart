import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeApp extends StatefulWidget {
  const HomeApp({super.key});

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          backgroundColor: Colors.grey,
          onPressed: () {},
          child: const Icon(
            Icons.mic,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
        child: BottomAppBar(
          shape: AutomaticNotchedShape(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
          color: Colors.grey,
          child: Container(
            height: 70,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 16, top: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 35),
              child: Text(
                "Bem vindo, user",
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: ((context, index) {
                  return Container(
                    width: 90,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      "$index",
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  );
                }),
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 10,
                  );
                },
                itemCount: 10,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 36, left: 15),
              child: SizedBox(
                height: 140,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: ((context, index) {
                    return Container(
                      width: 250,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        "$index",
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    );
                  }),
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      width: 22,
                    );
                  },
                  itemCount: 10,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 36),
              child: Container(
                width: 100,
                height: 30,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 36, left: 15),
              child: SizedBox(
                height: 140,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: ((context, index) {
                    return Container(
                      width: 250,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        "$index",
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    );
                  }),
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      width: 22,
                    );
                  },
                  itemCount: 10,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 36),
              child: Container(
                width: 100,
                height: 30,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
