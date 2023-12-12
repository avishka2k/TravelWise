import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Groups extends StatefulWidget {
  const Groups({super.key});

  @override
  State<Groups> createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: const Icon(
                Icons.add,
                size: 30,
              ),
              onPressed: () {},
            ),
          ),
        ],
        title: const Text("Groups"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .collection('groups')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map(
              (DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage('assets/sun.jpg'),
                  ),
                  title: Text(data['title']),
                  subtitle: Text('${data['members'].length} members'),
                );
              },
            ).toList(),
          );
        },
      ),
    );
  }
}


// this is also work-- array list

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class Groups extends StatefulWidget {
//   const Groups({super.key});

//   @override
//   State<Groups> createState() => _GroupsState();
// }

// class _GroupsState extends State<Groups> {
//   User? user = FirebaseAuth.instance.currentUser;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 10),
//             child: IconButton(
//               icon: const Icon(
//                 Icons.add,
//                 size: 30,
//               ),
//               onPressed: () {},
//             ),
//           ),
//         ],
//         title: const Text("Groups"),
//         centerTitle: true,
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('users')
//             .doc(user!.uid)
//             .collection('groups')
//             .snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasError) {
//             return const Text('Something went wrong');
//           }

//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Text("Loading");
//           }

//           return ListView.builder(
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (context, index) {
//               DocumentSnapshot document = snapshot.data!.docs[index];
//               Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

//               return FutureBuilder<ListTile>(
//                 future: buildListTile(data),
//                 builder: (BuildContext context, AsyncSnapshot<ListTile> snapshot) {
//                   if (snapshot.connectionState == ConnectionState.done) {
//                     return snapshot.data!;
//                   } else {
//                     return const SizedBox(); // Placeholder, you can use a loading indicator
//                   }
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   Future<ListTile> buildListTile(Map<String, dynamic> data) async {
//     List<DocumentReference> memberReferences = List<DocumentReference>.from(data['members']);
//     List<String> memberNames = [];

//     for (DocumentReference reference in memberReferences) {
//       DocumentSnapshot memberSnapshot = await reference.get();
//       Map<String, dynamic> memberData = memberSnapshot.data() as Map<String, dynamic>;
//       memberNames.add(memberData['fullname']);
//     }

//     return ListTile(
//       leading: const CircleAvatar(
//         backgroundImage: AssetImage('assets/sun.jpg'),
//       ),
//       title: Text(data['title']),
//       subtitle: Text('Members: ${memberNames.join(', ')}'),
//     );
//   }
// }
