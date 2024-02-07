import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blood_connect/components/components.dart';
import 'package:flutter_blood_connect/constants.dart';
import 'package:flutter_blood_connect/controllers/app_cubit/app_cubit.dart';
import 'package:flutter_blood_connect/controllers/auth_cubit/auth_cubit.dart';
import 'package:flutter_blood_connect/components/flip_card_widget.dart';
import 'package:flutter_blood_connect/screens/login_screen.dart';
import 'package:flutter_blood_connect/screens/profile_screen.dart';
import 'package:flutter_blood_connect/screens/register_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import "dart:html" as html;
import '../utils/app_cache.dart';
import 'donation_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? user = AppCache.getData(key: "token") ?? "";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> auth = [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          onPressed: () {
            pushNavigation(context, RegisterScreen());
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)))),
          child: const Text(
            "Register",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          onPressed: () {
            pushNavigation(context, LoginScreen());
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)))),
          child: const Text(
            "Login",
            style: TextStyle(color: Colors.white),
          ),
        ),
      )
    ];
    List<Widget> donate = [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          onPressed: () {
            pushNavigation(context, DonationScreen());
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)))),
          child: const Text("Donate"),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          onPressed: () {
            requestBloodDialog(context);
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)))),
          child: const Text("Request"),
        ),
      ),
      BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LogoutSuccessState) {
            html.window.location.reload();
            pushAndRemoveUntil(context, HomeScreen());
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text("My Profile"),
                  onTap: () {
                    pushNavigation(context, const ProfileScreen());
                  },
                ),
                PopupMenuItem(
                  child: const Text("Logout"),
                  onTap: () {
                    AuthCubit().get(context).logout();
                  },
                )
              ],
              child: const Row(
                children: [
                  Text("User"),
                  SizedBox(
                    width: 2,
                  ),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
          );
        },
      )
    ];
    List<Widget> actions = user == "" ? auth : donate;
    return Scaffold(
      appBar: myAppBar(actions: actions),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              child: Stack(
                children: [
                  Image.asset(
                    "assets/images/welcome_image.jpg",
                    height: getScreenSize(context).height,
                    width: getScreenSize(context).width,
                    fit: BoxFit.cover,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: getScreenSize(context).width / 2,
                      height: getScreenSize(context).height,
                      color: Colors.white.withAlpha(210),
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Expanded(flex: 6, child: SizedBox()),
                            const Text(
                              "Donate Your Blood to\nUs, Save More Life\nTogether",
                              style: TextStyle(
                                  fontSize: 45, fontWeight: FontWeight.w900),
                            ),
                            const Expanded(
                              child: SizedBox(),
                            ),
                            SizedBox(
                              width: getScreenSize(context).width / 2.7,
                              child: const Text(
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor .",
                                  style: TextStyle(height: 1.6)),
                            ),
                            const Expanded(child: SizedBox()),
                            ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)))),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 12),
                                child: Text(
                                  "About us",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            const Expanded(flex: 4, child: SizedBox()),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Image.asset(
              "assets/images/comma.png",
              width: 75,
              height: 75,
            ),
            const Text(
              '"Donate Your Blood to Us, Save More Life Together"',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              "John Doe",
              style: TextStyle(color: Colors.red.shade600, fontSize: 17),
            ),
            const SizedBox(height: 100),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "About Us",
                      style: TextStyle(color: Colors.red.shade600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Together We Can\nMake World More Health & Better",
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: getScreenSize(context).width / 3,
                      child: Text(
                        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim.",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.done,
                                  color: Colors.green,
                                ),
                                Text(
                                  "Good Health",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.done,
                                  color: Colors.green,
                                ),
                                Text(
                                  "24h Service",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.done,
                                  color: Colors.green,
                                ),
                                Text(
                                  "Help People",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.done,
                                  color: Colors.green,
                                ),
                                Text(
                                  "Health Check",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.done,
                                  color: Colors.green,
                                ),
                                Text(
                                  "Hygine Tools",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.done,
                                  color: Colors.green,
                                ),
                                Text(
                                  "Blood Bank",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: getScreenSize(context).height / 6,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)))),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 12),
                        child: Text(
                          "About us",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                Image.asset(
                  "assets/images/about_us.jpg",
                  width: getScreenSize(context).width / 2.7,
                )
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Before Donating Your Blood",
              style: TextStyle(fontSize: 27, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.red.shade300,
              child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: 4,
                  children: List.generate(flipStatus.length, (index) {
                    FlipCardController flipCardController =
                        FlipCardController();
                    return SizedBox(
                      width: 50,
                      height: 50,
                      child: MouseRegion(
                          onEnter: (event) async {
                            await flipCardController
                                .flipCard(flipStatus[index]);

                            flipStatus[index] = !flipStatus[index];
                          },
                          onExit: (event) async {
                            await flipCardController
                                .flipCard(flipStatus[index]);

                            print(flipStatus[index]);
                            flipStatus[index] = !flipStatus[index];
                          },
                          child: FlipCardWidget(
                              flipCardController: flipCardController,
                              back: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Card(
                                  color: Colors.green.shade300,
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      child: Text(
                                        beforeDonation.values.elementAt(index),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              front: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Card(
                                  color: Colors.red.shade900,
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                          beforeDonation.keys.elementAt(index),
                                          style: const TextStyle(
                                              fontSize: 24,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                  ),
                                ),
                              ))),
                    );
                  })),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              "Team",
              style: TextStyle(color: Colors.red.shade600),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Expert Staff",
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
                "Lorem ipsum dolor sit amet, consectetuer adipiscing elit.\nAenean commodo ligula eget dolor. Aenean massa."),
            BlocBuilder<AppCubit, AppState>(
              builder: (context, state) {
                var cubit = AppCubit().get(context);
                return BuildCondition(
                  condition: cubit.doctorModel != null,
                  builder: (context) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          3,
                          (index) => Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      child: Image.network(
                                        "$baseUrl${cubit.doctorModel?.doctors[index].image}",
                                        width: getScreenSize(context).width / 5,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(12.0),
                                      decoration: BoxDecoration(
                                          color: Colors.red.shade700,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      padding: const EdgeInsets.all(27),
                                      child: Text(
                                        "${cubit.doctorModel?.doctors[index].name}",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                    );
                  },
                  fallback: (context) => const SizedBox(
                    height: 100,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 70,
            ),
            const Text(
              "After Donating Your Blood",
              style: TextStyle(fontSize: 27, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.red.shade300,
              child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: 4,
                  children: List.generate(flipStatus.length, (index) {
                    FlipCardController flipCardController =
                        FlipCardController();
                    return SizedBox(
                      width: 50,
                      height: 50,
                      child: MouseRegion(
                          onEnter: (event) async {
                            await flipCardController
                                .flipCard(flipStatus[index]);

                            flipStatus[index] = !flipStatus[index];
                          },
                          onExit: (event) async {
                            await flipCardController
                                .flipCard(flipStatus[index]);

                            print(flipStatus[index]);
                            flipStatus[index] = !flipStatus[index];
                          },
                          child: FlipCardWidget(
                              flipCardController: flipCardController,
                              back: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Card(
                                  color: Colors.green.shade300,
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      child: Text(
                                        afterDonation.values.elementAt(index),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              front: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Card(
                                  color: Colors.red.shade900,
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                          afterDonation.keys.elementAt(index),
                                          style: const TextStyle(
                                              fontSize: 24,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                  ),
                                ),
                              ))),
                    );
                  })),
            ),
            const SizedBox(height: 40),
            const Text("Blood Donation Event",
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900)),
            const SizedBox(height: 30),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: events.map((e) {
                  return Column(children: [
                    Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          children: [
                            Image.asset(e.keys.elementAt(e.length - 1),
                                width: getScreenSize(context).width / 4,
                                height: getScreenSize(context).height / 2.5,
                                fit: BoxFit.cover),
                            Row(children: [
                              Container(
                                  width: (getScreenSize(context).width / 4) / 2,
                                  padding: const EdgeInsets.all(12.0),
                                  color: Colors.red.shade700,
                                  child: const Text("19/7/2022",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16))),
                              Container(
                                  width: (getScreenSize(context).width / 4) / 2,
                                  padding: const EdgeInsets.all(12.0),
                                  color: Colors.red.shade400,
                                  child: const Text("10 am - 1 pm",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16))),
                            ]),
                            Container(
                              width: getScreenSize(context).width / 4,
                              padding: const EdgeInsets.all(15.0),
                              color: Colors.grey.shade200,
                              child: const Text("RSUP Sanglah",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18)),
                            ),
                          ],
                        )),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: getScreenSize(context).width / 6,
                      child: Text(e.values.elementAt(e.length - 1),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              height: 1.6,
                              fontSize: 24,
                              fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: getScreenSize(context).width / 6,
                      child: const Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            height: 1.6,
                          )),
                    )
                  ]);
                }).toList()),
            const SizedBox(height: 40),
            const Text("Advantages of Donating Blood",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600)),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.red.shade300,
              child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: 4,
                  children: List.generate(flipStatus.length, (index) {
                    FlipCardController flipCardController =
                        FlipCardController();
                    return SizedBox(
                      width: 50,
                      height: 50,
                      child: MouseRegion(
                          onEnter: (event) async {
                            await flipCardController
                                .flipCard(flipStatus[index]);

                            flipStatus[index] = !flipStatus[index];
                          },
                          onExit: (event) async {
                            await flipCardController
                                .flipCard(flipStatus[index]);

                            print(flipStatus[index]);
                            flipStatus[index] = !flipStatus[index];
                          },
                          child: FlipCardWidget(
                              flipCardController: flipCardController,
                              back: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Card(
                                  color: Colors.green.shade300,
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      child: Text(
                                        advantagesofDonation.values
                                            .elementAt(index),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              front: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Card(
                                  color: Colors.red.shade900,
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                          advantagesofDonation.keys
                                              .elementAt(index),
                                          style: const TextStyle(
                                              fontSize: 24,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                  ),
                                ),
                              ))),
                    );
                  })),
            ),
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 3,
                  child: Lottie.asset("assets/images/footer.json",
                      fit: BoxFit.cover),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Blood Connect",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "GreatVibes",
                              fontSize: 34,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Lorem ipsum dolor sit amet consectet adipireti\nscing elit sed do eiusmod tempor incidi.",
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                                onPressed: () {},
                                child:
                                    const FaIcon(FontAwesomeIcons.facebookF)),
                            const SizedBox(
                              width: 3,
                            ),
                            ElevatedButton(
                                onPressed: () {},
                                child:
                                    const FaIcon(FontAwesomeIcons.instagram)),
                            const SizedBox(
                              width: 3,
                            ),
                            ElevatedButton(
                                onPressed: () {},
                                child: const FaIcon(FontAwesomeIcons.twitter)),
                            const SizedBox(
                              width: 3,
                            ),
                            ElevatedButton(
                                onPressed: () {},
                                child: const FaIcon(FontAwesomeIcons.youtube)),
                          ],
                        )
                      ],
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          "Useful Links",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.locationDot,
                              size: 17,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Jl. P.B. Sudirman, Dauh Puri,\nDenpasar, Bali",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.phone,
                              size: 17,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "+963900000000",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            FaIcon(
                              Icons.email,
                              size: 17,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "bloodconnect@mail.com",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          "Work Hours",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 20),
                        const Text("Sat - Thu : 09:00 AM - 19:00 AM",
                            style: TextStyle(color: Colors.white)),
                        const SizedBox(height: 20),
                        const Text("Need For Help? Call Us",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                        const SizedBox(height: 20),
                        ElevatedButton(
                            onPressed: () {},
                            child: const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Row(
                                children: [
                                  FaIcon(
                                    Icons.phone,
                                    size: 17,
                                  ),
                                  SizedBox(width: 5),
                                  Text("Contact Us",
                                      style: TextStyle(color: Colors.white)),
                                ],
                              ),
                            ))
                      ],
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
