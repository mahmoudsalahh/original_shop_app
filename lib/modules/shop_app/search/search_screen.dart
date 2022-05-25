
import 'package:flutter/material.dart';
import 'package:salahh/shared/shared.component/component.dart';

class SearchScreen extends StatelessWidget {
  //const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchController =TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body:
      Column(
      children: [
              Padding(
              padding: const EdgeInsets.all(20.0),
        child: defaulttextformfeild(

          controller: searchController,
          label: 'Search',
          prefix: Icons.search ,
          type: TextInputType.text,
          onchange:(value){
          },
          validate: (value){
            if(value.isEmpty){
              return 'this is Empty Field';
            }
            return null;
          },
        ),
      ),

          ],

      )
    );
  }
}
