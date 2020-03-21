import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'questdetailpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuestPage extends StatelessWidget {

  List<String> mockList = ["Test1", "Aufgabe", "Hände waschen"];

  @override
  Widget build(BuildContext context) {
    
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder(
          stream: Firestore.instance.collection('tasks').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(snapshot.hasError)
              return new Text("Error: ${snapshot.error}");
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return new Text("Loading...");
              default:
                return new ListView(
                  children: 
                    snapshot.data.documents.map((DocumentSnapshot document) {
                      return new ListTile(
                        leading: Icon(Icons.album, size:50),
                        title: Text(document['title']),
                        subtitle: Text(document['description']),
                      );
                    }).toList(),
                );
            }
          },
        ),
      ),
    );
    
  }
}





// ListView.builder(
//       itemCount: mockList.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => QuestDetailPage(content: mockList[index],)
//               ),
//             );
//           },
//           title: Text(mockList[index]),
//         );
//       }
//     );