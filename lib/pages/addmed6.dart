import 'package:flutter/material.dart';

class Addmed6 extends StatelessWidget {
  const Addmed6({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 530),
        Expanded(
          child: Container(
            width:double.infinity ,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
          child:
          Center(
            child: Wrap(
             
              children: [
                 GestureDetector(onTap: () {
              print('hi');
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface,borderRadius: BorderRadius.circular(15)),
                
                child: Image.asset('assets/images/drug.png',),
                height: 80,
                width: 80,),
            ),
              ),
               GestureDetector(onTap: () {
              print('hi');
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                 decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface,borderRadius: BorderRadius.circular(15)),
                child: Image.asset('assets/images/injection.PNG'),
                height: 80,
                width: 80,),
            ),
              ),
               GestureDetector(onTap: () {
              print('hi');
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                 decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface,borderRadius: BorderRadius.circular(15)),
                child: Image.asset('assets/images/dropper.PNG'),
                height: 80,
                width: 80,),
            ),
              ),
               GestureDetector(onTap: () {
              print('hi');
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                 decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface,borderRadius: BorderRadius.circular(15)),
                child: Image.asset('assets/images/bluebottle.png'),
                height: 80,
                width: 80,),
            ),
              ),
               GestureDetector(onTap: () {
            print('hi');
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
               decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface,borderRadius: BorderRadius.circular(15)),
              child: Image.asset('assets/images/C9C395AC-FCE9-471C-8A72-0BC6803BB887 1.png'),
              height: 80,
              width: 80,),
          ),
            ),
             GestureDetector(onTap: () {
            print('hi');
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
               decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface,borderRadius: BorderRadius.circular(15)),
              child: Image.asset('assets/images/6AEAE757-D8BE-4C19-9FCA-560FA3CE2239.PNG'),
              height: 80,
              width: 80,),
          ),
            ),
            
              ],),
          ),
          
            
          ),
        )],);
        
  }
}