import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_booking_app/models/actor_model.dart';

import '../../../core/components/header_admin.dart';
import '../../../core/constants/constants.dart';
import '../../../core/constants/ultis.dart';
import '../bloc/actor_bloc.dart';

class ActorAdminScreen extends StatelessWidget {
  const ActorAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const HeaderAdmin(title: "Actor Manager"),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  splashColor: Colors.red,
                  hoverColor: Colors.white54,
                  onTap: () {
                    // Getx.Get.to(() => (const AddNewRoom()),
                    //     transition: Getx.Transition.cupertino,
                    //     duration: const Duration(seconds: 2));
                  },
                  child: Container(
                    width: 195,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Constants.bgColorAdmin,
                    ),
                    child: const ListTile(
                      title: Text(
                        "Add new Actor",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: 500,
                    color: Constants.bgColorAdmin,
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) async {
                        if (context.mounted) {
                          context
                              .read<ActorBloc>()
                              .add(LoadSearchActorEvent(id: value));
                        }
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Write the actor id u wanna find",
                        labelStyle: const TextStyle(color: Colors.white),
                        suffix: InkWell(
                            onTap: () {
                              searchController.clear();
                              context
                                  .read<ActorBloc>()
                                  .add(const LoadSearchActorEvent(id: ""));
                            },
                            child: const Icon(
                              Icons.clear,
                              color: Colors.red,
                            )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            _actorListBuilder(),
          ],
        ),
      ),
    ));
  }

  BlocConsumer<ActorBloc, ActorState> _actorListBuilder() {
    return BlocConsumer<ActorBloc, ActorState>(
            listener: (context, state) {
              if (state is ActorErrorState) {
                //print(state.error);
              }
            },
            builder: (context, state) {
              if (state is ActorLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ActorLoadedState) {
                List<Actor> actorList = state.actor;
                return Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: actorList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Constants.bgColorAdmin,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        actorList[index].avatar,
                                        width: 200,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(14.0),
                                              child: Text(
                                                "Actor ID :",
                                                style: TextStyle(
                                                    color: Colors.white54,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Text(
                                              actorList[index].id,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 24,
                                                  fontWeight:
                                                      FontWeight.w700),
                                            ),
                                            Container(
                                                margin: const EdgeInsets.only(
                                                    left: 10),
                                                child: InkWell(
                                                  onTap: () {
                                                    // this is for copy text
                                                    Clipboard.setData(
                                                        ClipboardData(
                                                            text: actorList[
                                                                    index]
                                                                .id));
                                                    showToastSuccess(
                                                        context, "Copied");
                                                  },
                                                  child: Image.asset(
                                                    Constants.copyPath,
                                                    color: Colors.white,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(14.0),
                                              child: Text(
                                                "Actor name :",
                                                style: TextStyle(
                                                    color: Colors.white54,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Text(
                                              actorList[index].name,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 24,
                                                  fontWeight:
                                                      FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(14.0),
                                              child: Text(
                                                "Actor country :",
                                                style: TextStyle(
                                                    color: Colors.white54,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Text(
                                              actorList[index].country,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 24,
                                                  fontWeight:
                                                      FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(14.0),
                                              child: Text(
                                                "Actor Dob  :",
                                                style: TextStyle(
                                                    color: Colors.white54,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Text(
                                              actorList[index].dob,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 24,
                                                  fontWeight:
                                                      FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Spacer()
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
          );
  }
}
