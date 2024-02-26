import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_dinny/controller/editpro_controller.dart';

class EditScreen extends StatefulWidget {
  const EditScreen(
      {Key? key,
      required this.userName,
      required this.emailId,
      required this.phoneNumber})
      : super(key: key);
  final String userName;
  final String emailId;
  final String phoneNumber;
  @override
  State<EditScreen> createState() => _EditScreenState();
}

EditController editController = Get.put(EditController());
TextEditingController username = TextEditingController();
TextEditingController phonenumber = TextEditingController();
TextEditingController emailController = TextEditingController();

class _EditScreenState extends State<EditScreen> {
  @override
  void initState() {
    super.initState();
    username.text = widget.userName;
    phonenumber.text = widget.phoneNumber;

    emailController.text = widget.emailId;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      Stack(
        children: [
          Container(
            height: size.height * 0.30,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assest/images/profile image.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage(
                      'assest/images/blank-profile-picture-973460-1-1-1080x1080.png',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: username,
                    decoration: const InputDecoration(
                      labelText: 'Email ID',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: phonenumber,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.only(top: 200, left: 17, right: 8),
              child: ElevatedButton(
                onPressed: () async {
                  await editController.updateUserDetails(
                    newEmail: username.text,
                    newName: emailController.text,
                    newPhoneNumber: phonenumber.text,
                  );
                  Get.back();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 3, 81, 12),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all<Size>(
                    const Size(double.infinity, 50),
                  ),
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        )),
      ),
    ])));
  }
}
