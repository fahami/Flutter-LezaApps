import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resto/config/text_style.dart';
import 'package:resto/helpers/database_helper.dart';
import 'package:resto/helpers/preference_helper.dart';
import 'package:resto/provider/scheduling_provider.dart';
import 'package:resto/provider/setting_provider.dart';

class Settings extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SettingProvider()),
          ChangeNotifierProvider(create: (_) => SchedulingProvider()),
        ],
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Consumer<SchedulingProvider>(
              builder: (context, schedule, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Hello!'),
                              Text(user!.displayName ?? 'Pelanggan Baru',
                                  style: heading1),
                              Text(user!.email ??
                                  'Semoga puas dengan layanan kami')
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Hero(
                            tag: 'profileHero',
                            child: CircleAvatar(
                              maxRadius: 40,
                              backgroundImage: NetworkImage(user!.photoURL ??
                                  'https://karyasa.my.id/users.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Pengaturan',
                      style: heading2,
                    ),
                    Divider(),
                    Consumer<SettingProvider>(
                      builder: (context, setting, _) {
                        return SwitchListTile(
                          title: Text('Rekomendasi restoran'),
                          value: setting.reminder,
                          onChanged: (bool value) {
                            schedule.scheduledRecommendation(value);
                            setting.setReminder(value);
                          },
                        );
                      },
                    ),
                    ListTile(
                      title: Text('Keluar'),
                      trailing: Icon(Icons.logout),
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        await PreferencesHelper.clearPreferences();
                        await Provider.of<SchedulingProvider>(context,
                                listen: false)
                            .scheduledRecommendation(false);
                        await DatabaseHelper().removeDatabase();
                        Get.offAllNamed('/onboard');
                      },
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
