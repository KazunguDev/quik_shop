// ignore_for_file: deprecated_member_use
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';

import 'package:quik_shop/body_widgets/header_widget.dart';
import 'package:get/get.dart';
import 'package:quik_shop/components/profile_tile.dart';
import 'package:quik_shop/constants.dart';
import 'package:quik_shop/screens/profile_screens/about_us.dart';
import 'package:quik_shop/screens/profile_screens/accountsetting_screen.dart';
import 'package:quik_shop/screens/profile_screens/address.dart';
import 'package:quik_shop/screens/profile_screens/feedback.dart';
import 'package:quik_shop/screens/profile_screens/my_order_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final DatabaseReference _databaseReference;
  final currentUser = FirebaseAuth.instance.currentUser!.uid;
  late String firstName;
  late String lastName;
  @override
  void initState() {
    _databaseReference = FirebaseDatabase.instance.reference();
    readDatabase();
    super.initState();
  }

  readDatabase() {
    _databaseReference
        .child('Details')
        .child(currentUser.toString())
        .child(0.toString())
        .child('FirstName')
        .once()
        .then((value) {
      setState(() {
        firstName = value.snapshot.value.toString();
      });
    });
    _databaseReference
        .child('Details')
        .child(currentUser.toString())
        .child(0.toString())
        .child('LastName')
        .once()
        .then((value) {
      setState(() {
        lastName = value.snapshot.value.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 90,
          elevation: 0.5,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Theme.of(context).primaryColor,
                      Theme.of(context).colorScheme.secondary,
                    ])),
          ),
        ),
        SliverToBoxAdapter(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                SizedBox(
                    height: 100,
                    child: HeaderWidget(
                      showIcon: false,
                      height: 100,
                      icon: Icons.person,
                    )),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(width: 5, color: Colors.white),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 20,
                            offset: Offset(5, 5),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.person,
                        size: 80,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "$firstName $lastName",
                      style: kTextStyleLarge,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(26.0),
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                              onTap: () {
                                Get.to(() => OrdersScreen(),
                                    transition: Transition.cupertino);
                              },
                              child: tile(
                                  'My Orders', Icons.shopping_basket_rounded)),
                          GestureDetector(
                              onTap: () {
                                Get.to(() => AddressScreen(),
                                    transition: Transition.cupertino);
                              },
                              child: tile('Address', Icons.location_on)),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => AccountSettingScreen(),
                                  transition: Transition.cupertino);
                            },
                            child: tile('Account Settings', Icons.settings),
                          ),
                          GestureDetector(
                              onTap: () {
                                Get.to(() => FeedBackScreen(),
                                    transition: Transition.cupertino);
                              },
                              child: tile('Feedback', Icons.feedback_sharp)),
                          GestureDetector(
                              onTap: () {
                                Get.to(() => AboutUs(),
                                    transition: Transition.cupertino);
                              },
                              child: tile('About Us', Icons.info)),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}