import 'package:learning_project/Constant/images.dart';
import 'package:learning_project/Constant/public_constant.dart';
import 'package:learning_project/Helper/cach_helper.dart';
import 'package:learning_project/Module/Auth/View/Login.dart';
import 'package:learning_project/Module/Auth/authcubit/authcubit.dart';
import 'package:learning_project/Module/Auth/authcubit/authstate.dart';
import 'package:learning_project/Module/Profile/Cubit/cubit/profile_cubit.dart';
import 'package:learning_project/Module/Profile/View/profile_page.dart';
import 'package:learning_project/Utils/Big_text.dart';
import 'package:learning_project/generated/l10n.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<Widget> _pages = [
    Center(child: BigText("HOME PAGE")),
    Center(child: BigText("Search")),
    Center(child: BigText("Notifications")),
    Center(child: BigText("Settings")),
    Center(child: BigText("Profile")),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      if (index == 4) {
        pushTo(context: context, toPage: UploadPage());
      } else {
        setState(() {
          selectedIndex = index;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => ProfileCubit()),
      ],
      child: BlocListener<AuthCubit, Authstate>(
        listener: (context, state) {
          if (state is LogOutSuccess) {
            pushAndRemoveUntiTo(context: context, toPage: LoginPage());
          }
          customSnackBar(
            context: context,
            success: 1,
            message: S.of(context).success,
          );
        },
        child: BlocBuilder<AuthCubit, Authstate>(
          builder: (context, state) {
            final AuthCubit cubit = AuthCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                toolbarHeight: 80.h,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                        String? imagePath;

                        if (state is ProfileUploaded) {
                          imagePath = state.imageUrl;
                        } else {
                          imagePath = CacheHelper.getData(key: "profile_image");
                        }

                        return CircleAvatar(
                          radius: 35.r,
                          backgroundImage: NetworkImage(
                            imagePath ?? Images.profile,
                          ),
                          backgroundColor: Colors.grey[300],
                        );
                      },
                    ),

                    SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.logout),
                      onPressed: () => cubit.logOut(),
                    ),
                  ],
                ),
              ),
              body: _pages[selectedIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: selectedIndex,
                onTap: _onItemTapped,
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.grey,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: "Search",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.notifications),
                    label: "Notifications",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: "Settings",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: "Profile",
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
