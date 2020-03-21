import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'questdetailpage.dart';

class QuestPage extends StatelessWidget {

  List<String> mockList = ["Test1", "Aufgabe", "Hände waschen"];

  @override
  Widget build(BuildContext context) {
    return 
    ListView.builder(
      itemCount: mockList.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuestDetailPage(content: mockList[index],)
              ),
            );
          },
          title: Text(mockList[index]),
        );
      }
    );
  }
}