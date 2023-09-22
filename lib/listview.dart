// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';

// class SlidableList extends StatelessWidget {
//   const SlidableList({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         children: [
//           SlidableItem(),
//           SlidableItem(),
//         ],
//       ),
//     );
//   }
// }

// class SlidableItem extends StatelessWidget {
//   const SlidableItem({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Slidable(
//       key: Key('unique_key'),
//       startActionPane: ActionPane(
//         motion: const ScrollMotion(),
//         children: const [
//           SlidableAction(
//             onPressed: doNothing,
//             backgroundColor: Color(0xFFFE4A49),
//             foregroundColor: Colors.white,
//             icon: Icons.delete,
//             label: 'Delete',
//           ),
//         ],
//       ),
//       child: ListTile(title: Text('Slide me')),
//     );
//   }
// }

// void doNothing(BuildContext context) {
// }
//
//

import 'package:flutter/material.dart';
import 'package:travelwise/app_data.dart';

class MyAppsd extends StatelessWidget {
  MyAppsd({super.key});

  List<Member> members = [
    Member(
        titile: 'Avishka Prabath',
        subtitle: 'avishkaprabath@gmail.com',
        imageUrl:
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80'),
    Member(
        titile: 'Kalani Kasthuriarachchi',
        subtitle: 'kalanikasthuriarachchi98@gmail.com',
        imageUrl:
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: appPagePadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Trip Members'),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Add Members'),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: members.length,
              itemBuilder: (BuildContext context, int index) {
                final member = members[index];
                return Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80'),
                    ),
                    title: Text(member.titile.toString()),
                    subtitle: Text(member.subtitle.toString()),
                    trailing: const Text('Remove'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Member {
  final String? titile;
  final String? subtitle;
  final String? imageUrl;

  Member({this.titile, this.subtitle, this.imageUrl});
}
