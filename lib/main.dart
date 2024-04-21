import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:side_bar/sidebar_model.dart';

// Define the sidebar status cubit
class SidebarCubit extends Cubit<SideBarModel> {
  SidebarCubit() : super(SideBarModel(false, false)); // Sidebar starts closed

  void toggleSidebar() => emit(SideBarModel(!state.open, state.showItem));
  void toggleShowItem() => emit(SideBarModel(state.open, !state.showItem));
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sidebar Example',
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => SidebarCubit(),
        child: const DashboardScreen(),
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            // flex: context.watch<SidebarCubit>().state ? 7 : 22,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppBar(
                  actions: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 16),
                            child: Container(
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  color: Colors.grey),
                              child: IconButton(
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                padding: const EdgeInsets.all(4),
                                constraints: const BoxConstraints(),
                                icon: const Icon(
                                  Icons.person_outline,
                                  color: Colors.white,
                                ), // Replace icon1 with your desired icon
                                onPressed: () {
                                  // Add your onPressed logic here
                                },
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 0.2,
                                ),
                                borderRadius: BorderRadius.circular(4)),
                            child: IconButton(
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              constraints: const BoxConstraints(),
                              padding: const EdgeInsets.all(4),
                              icon: const Icon(
                                Icons.settings_outlined,
                                color: Colors.grey,
                              ), // Replace icon2 with your desired icon
                              onPressed: () {
                                // Add your onPressed logic here
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  elevation: 0, // Remove the default shadow
                  shape: const Border(
                      bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.5)), // Add the border here
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: const Text(
                          "Main Dashboard!",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ).animate().move(),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn,
                width: context.watch<SidebarCubit>().state.open ? 200 : 55,
                decoration: const BoxDecoration(
                    border: Border(
                        left: BorderSide(color: Colors.grey, width: 0.5))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(
                            bottom: 20, left: 10, right: 10, top: 10),
                        child: context.watch<SidebarCubit>().state.open
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: Text(
                                        "تایمز",
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 24),
                                      )),
                                  Image.asset(
                                    "images/logo.png",
                                    scale: 5.5,
                                  ),
                                ],
                              ).animate().show(
                                duration: const Duration(milliseconds: 200))
                            : Image.asset(
                                "images/logo.png",
                                scale: 5.5,
                              )),

                    // ExpansionTile(title: Text("sss"),),
                    context.watch<SidebarCubit>().state.open
                        ? Directionality(
                            textDirection: TextDirection.rtl,
                            child: Container(
                              // constraints: const BoxConstraints(),
                              margin: const EdgeInsets.all(4),
                              child: ListTile(
                                contentPadding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                tileColor:
                                    context.watch<SidebarCubit>().state.showItem
                                        ? Colors.blue[50]
                                        : null,
                                horizontalTitleGap: 8,
                                leading: const Icon(
                                    Icons.format_list_bulleted_sharp),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      style: TextStyle(fontSize: 12.5),
                                      'فرم ساز',
                                    ),
                                    context.watch<SidebarCubit>().state.showItem
                                        ? const Icon(Icons.keyboard_arrow_up)
                                        : const Icon(Icons.keyboard_arrow_down)
                                  ],
                                ),
                                onTap: () {
                                  // Handle Home item tap
                                  context.read<SidebarCubit>().toggleShowItem();
                                },
                              ).animate().show(
                                  duration: const Duration(milliseconds: 200)),
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.all(4),
                            child: ListTile(
                              contentPadding: EdgeInsets.only(left: 15),
                              tileColor:
                                  context.watch<SidebarCubit>().state.showItem
                                      ? Colors.blue[50]
                                      : null,
                              leading:
                                  const Icon(Icons.format_list_bulleted_sharp),
                              onTap: () {},
                            ),
                          ),
                    context.watch<SidebarCubit>().state.showItem
                        ? Directionality(
                            textDirection: TextDirection.rtl,
                            child: ListTile(
                              contentPadding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              horizontalTitleGap: 8,
                              title: context.watch<SidebarCubit>().state.open
                                  ? const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 10.0),
                                          child: Text(
                                            style: TextStyle(fontSize: 12.5),
                                            'ساختن فرم',
                                          ),
                                        ),
                                      ],
                                    )
                                  : null,
                              onTap: () {
                                // Handle Home item tap
                              },
                            ),
                          )
                            .animate()
                            .slideY(duration: const Duration(milliseconds: 200))
                        : Container(),

                    context.watch<SidebarCubit>().state.open
                        ? Directionality(
                            textDirection: TextDirection.rtl,
                            child: Container(
                              margin: EdgeInsets.all(5),
                              child: ListTile(
                                contentPadding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                horizontalTitleGap: 8,
                                leading: const Icon(Icons.person_2_outlined),
                                title: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      style: TextStyle(fontSize: 12.5),
                                      'حضور و غیاب',
                                    ),
                                    Icon(Icons.keyboard_arrow_down)
                                  ],
                                ),
                                onTap: () {
                                  // Handle Home item tap
                                },
                              ).animate().show(
                                  duration: const Duration(milliseconds: 200)),
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.all(5),
                            child: ListTile(
                                contentPadding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                horizontalTitleGap: 8,
                                leading: const Icon(Icons.person_2_outlined),
                                onTap: () {
                                  // Handle Home item tap
                                })),

                    // Directionality(
                    //   textDirection: TextDirection.rtl,
                    //   child: ListTile(
                    //     contentPadding:
                    //         const EdgeInsets.only(left: 10, right: 10),
                    //     horizontalTitleGap: 8,
                    //     leading: const Icon(Icons.lock),
                    //     title: context.watch<SidebarCubit>().state.open
                    //         ? const Row(
                    //             mainAxisAlignment:
                    //                 MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               Text(
                    //                 style: TextStyle(fontSize: 12.5),
                    //                 'مدیریت دسترسی',
                    //               ),
                    //             ],
                    //           ).animate().show(
                    //             duration: const Duration(milliseconds: 200))
                    //         : null,
                    //     onTap: () {
                    //       // Handle Home item tap
                    //     },
                    //   ),
                    // ),
                    const Spacer(),
                    Stack(children: [
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: ListTile(
                          tileColor: Colors.blue[50],
                          contentPadding:
                              const EdgeInsets.only(left: 10, right: 10),
                          horizontalTitleGap: 8,
                          leading: const Icon(
                            Icons.settings,
                            color: Colors.blue,
                          ),
                          title: context.watch<SidebarCubit>().state.open
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 400),
                                      child: const Text(
                                        style: TextStyle(
                                            fontSize: 12.5, color: Colors.blue),
                                        'داشبورد',
                                      ),
                                    ),
                                  ],
                                ).animate().show(
                                  duration: const Duration(milliseconds: 200))
                              : null,
                          onTap: () {
                            // Handle Home item tap
                            context.read<SidebarCubit>().toggleSidebar();
                          },
                        ),
                      ),
                      Transform.translate(
                          offset: const Offset(-16, 10),
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: IconButton(
                              onPressed: () {
                                context.read<SidebarCubit>().toggleSidebar();
                              },
                              icon: context.watch<SidebarCubit>().state.open
                                  ? const Icon(
                                      Icons.keyboard_arrow_right,
                                      color: Colors.grey,
                                    )
                                  : const Icon(
                                      Icons.keyboard_arrow_left,
                                      color: Colors.grey,
                                    ),
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              padding: EdgeInsets.zero,
                              constraints: constraints,
                            ),
                          ))
                    ]),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
