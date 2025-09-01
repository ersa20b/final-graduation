import 'package:flutter/material.dart';

class HealthJournalCard extends StatelessWidget {
  const HealthJournalCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:Theme.of(context).colorScheme.surface, 
        borderRadius: BorderRadius.circular(26), 
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         
          Image.asset(
            'assets/images/drug.png', 
            height: 140,
            width: 120,
            fit: BoxFit.cover,
          ),
      
          const SizedBox(width: 6),
      
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Text(
                  'Your Health Journal ✨',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Center(
                  child: Text(
                    'Consistent medication use fosters healing and a healthier life.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}