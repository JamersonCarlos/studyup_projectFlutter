import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkList extends StatefulWidget {
  LinkList(
      {super.key,
      required this.setFloatingButton,
      required this.removeLink,
      required this.addLink});

  Function setFloatingButton;
  Function removeLink;
  Function addLink;

  @override
  State<LinkList> createState() => _LinkListState();
}

class _LinkListState extends State<LinkList> {
  List<String> links = [];
  TextEditingController linkInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: links.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xFF03045E),
                    borderRadius: BorderRadius.circular(5)),
                child: GestureDetector(
                  onTap: () async {
                    final Uri url = Uri.parse(links[index]);
                    if (!await launchUrl(url)) {
                      throw Exception('Could not launch $url');
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              links[index],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onTap: () {
                            setState(() {
                              links.removeAt(index);
                              widget.removeLink(index);
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                height: 40,
                child: TextField(
                  cursorColor: Colors.black,
                  onTap: () {
                    widget.setFloatingButton(false);
                  },
                  controller: linkInput,
                  decoration: const InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    widget.setFloatingButton(true);
                    currentFocus.unfocus();
                  }
                  bool _validURL = Uri.parse(linkInput.text).isAbsolute;
                  if (linkInput.text.isNotEmpty) {
                    if (_validURL) {
                      links.add(linkInput.text);
                      widget.addLink(linkInput.text);
                      linkInput.clear();
                    } else {
                      linkInput.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                            "Link Invalido !",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: Colors.red.shade400,
                        ),
                      );
                    }
                  }
                });
              },
              style: TextButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    bottomLeft: Radius.circular(0),
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                backgroundColor: Color(0xFF03045E),
              ),
              child: const Icon(
                Icons.add_link,
                color: Colors.white,
              ),
            )
          ],
        ),
      ],
    );
  }
}
