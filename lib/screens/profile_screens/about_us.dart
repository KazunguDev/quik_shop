import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quik_shop/body_widgets/header_widget.dart';
import 'package:quik_shop/components/profile_tile.dart';
import 'package:quik_shop/constants.dart';

import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('About Us', style: kTextStyleHeaders),
            elevation: 0.5,
            iconTheme: const IconThemeData(color: Colors.black),
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
                      height: 80,
                      child: HeaderWidget(
                        showIcon: false,
                        height: 80,
                      )),
                  Column(
                    children: [
                      const SizedBox(height: 100),
                      Padding(
                        padding: const EdgeInsets.all(26.0),
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                                onTap: () {
                                  Uri url = Uri.parse(
                                      'https://pages.flycricket.io/kwikshop/privacy.html');
                                  launchUrl(url);
                                },
                                child: tile(
                                    'Privacy Policy', Icons.lock)),
                            GestureDetector(
                              onTap: () {
                                Uri url = Uri.parse(
                                    'https://pages.flycricket.io/kwikshop/terms.html');
                                launchUrl(url);
                              },
                              child: tile('Terms and Conditions',
                                  Icons.verified_user_rounded),
                            ),
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
      ),
    );
  }
}