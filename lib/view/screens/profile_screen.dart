import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_dinny/controller/auth_controller.dart';
import 'package:user_dinny/controller/profile_controller.dart';
import 'package:user_dinny/view/screens/edit_screen.dart';
import 'package:user_dinny/view/screens/login.dart';
import 'package:user_dinny/view/screens/privacy_policies.dart';
import 'package:user_dinny/view/screens/settings_screen.dart';
import 'package:user_dinny/view/screens/terms_condition.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    UserProfileController profileInstance = Get.put(UserProfileController());
    AuthController authController=Get.put(AuthController());
    return Obx(() => StreamBuilder(
          stream: profileInstance.userProfileStream.value,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final userData = snapshot.data!.data() as Map<String, dynamic>;
              return Scaffold(
                body: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: size.height * 0.25,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assest/images/profile image.png'),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Positioned(
                          top: 50,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Column(
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: ClipOval(
                                    child: Image.asset(
                                      'assest/images/profile_logo-removebg-preview.png',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  userData['userName'] ?? '',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const SizedBox(height: 5),
                                Text(userData['phoneNumber'] ?? '',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ListTile(
                      onTap: () {
                        Get.to(EditScreen(
                          emailId: userData['userName'] ?? '',
                          phoneNumber: userData['phoneNumber'] ?? '',
                          userName: userData['email'] ?? '',
                        ));
                      },
                      leading: const Icon(Icons.edit),
                      title: const Text(
                        'Edit Profile',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ListTile(
                      onTap: () {
                        Share.share('am happy');
                      },
                      leading: const Icon(Icons.share),
                      title: const Text(
                        'Share',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ListTile(
                      onTap: () {
                        Get.to(const SettingsScreeen());
                      },
                      leading: const Icon(Icons.settings),
                      title: const Text(
                        'Settings',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ListTile(
                      onTap: () {
                        Get.to(const TermsAndConditionsScreen());
                      },
                      leading: const Icon(Icons.list_alt_rounded),
                      title: const Text(
                        'Terms and Conditions',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ListTile(
                      onTap: () {
                        Get.to(const PrivacyPolicyScreen());
                      },
                      leading: const Icon(Icons.policy),
                      title: const Text(
                        'Policies and privacy',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ListTile(
                      onTap: () {
                       authController.logout();
                      },
                      leading: const Icon(Icons.logout),
                      title: const Text(
                        'Log Out',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox(
                child: Center(
                  child: Text('Please Check your Internet Connection'),
                ),
              );
            }
          },
        ));
  }

  Future<void> _logoutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove('getuser_id');

      Get.offAll(const Login());
    } catch (e) {
      print("Error signing out: $e");
    }
  }
}
