import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:graduation_med_/constants/image_paths.dart';
import 'package:provider/provider.dart';
import 'package:graduation_med_/providers/profiles_provider.dart';
import 'package:graduation_med_/providers/medicine_provider.dart';
import 'package:graduation_med_/util/add_dependent_page.dart';
import 'package:graduation_med_/util/dependent_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final profilesProvider = context.watch<ProfilesProvider>();
    final profile = profilesProvider.activeProfile;
    final mainUser = profilesProvider.mainUser;
    final dependents = profilesProvider.dependents;

    final gender = profile.gender.toLowerCase();
    final avatarPath = gender == 'male'
        ? ImagePaths.maleAvatar
        : gender == 'female'
            ? ImagePaths.femaleAvatar
            : ImagePaths.defaultAvatar;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text("Profile", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              SizedBox(height: 30,),
            Container(
              height: 140,
              width: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(75),
                color: Colors.grey,
              ),
              child: CircleAvatar(
                radius: 28,
                backgroundImage: AssetImage(avatarPath),
              ),
            ),
            const SizedBox(height: 10),

            // اسم المستخدم الحالي وبريده
            Text(profile.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(profile.email.isEmpty ? 'No Email' : profile.email),
            const SizedBox(height: 20),

            // كارت المستخدم الرئيسي إذا كنا في حساب تابع
            if (!profile.isMainUser) ...[
              const Divider(),
              DependentCard(
                profile: mainUser,
                profileNumber: "Owner",
                medicineCount: context.watch<MedicineProvider>().getMedicineCountForUser(mainUser.id),
                isOwner: true,
                onTap: () {
                  profilesProvider.switchToMainUser();
                },
              ),
            ],

            //   التوابع (يظهر فقط للمستخدم الرئيسي)
            if (profile.isMainUser)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Dependencies", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.add_box, color: Colors.grey),
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AddDependentPage()),
                      );

                     

                      
                    },
                  ),
                ],
              ),

            if (profile.isMainUser) const Divider(),

            /// قائمة التوابع (فقط تظهر للمستخدم الرئيسي)
            if (profile.isMainUser)
              Expanded(
                child: ListView.builder(
                  itemCount: dependents.length,
                  itemBuilder: (context, index) {
                    final dep = dependents[index];
                    final medCount = context.watch<MedicineProvider>().getMedicineCountForUser(dep.id);
                    return Slidable(
  key: ValueKey(dep.id),
  direction: Axis.horizontal,
  startActionPane: ActionPane(
    motion: const StretchMotion(),
    extentRatio: 0.25,
    children: [
      CustomSlidableAction(
        onPressed: (_) async {
          final confirm = await showDialog<bool>(
            context: context,
            builder: (_) => AlertDialog(
              backgroundColor: Colors.grey.shade100,
              title: const Text('Delete Dependent'),
              content: const Text("Are you sure you want to delete this dependent?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Delete', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          );

          if (confirm == true) {
           await context.read<ProfilesProvider>().removeDependentFromFirestore(dep.id);


            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Dependent deleted successfully ')),
            );
          }
        },
        backgroundColor: Colors.transparent,
        child: const Icon(Icons.delete, color: Colors.red),
      ),
    ],
  ),
  child: DependentCard(
    profile: dep,
    profileNumber: "No. ${index + 2}",
    medicineCount: medCount,
    onTap: () {
      profilesProvider.setActiveProfile(dep);
    },
  ),
);

                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
