import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_gotipath/features/home/presentation/widgets/prayer_tile.dart';

import '../../domain/entities/home.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "home_screen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prayer Times"),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (BuildContext context, state) {
          log("state: $state");
          if (state is HomeStateLoading) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (state is HomeStateFetched ||
              state is HomeStateFiltered ||
              state is HomeStateLoadingMore) {
            List<HomeEntity>? items;
            bool isLoadingMore = false;

            if (state is HomeStateFetched) {
              items = state.homeItems;
            } else if (state is HomeStateFiltered) {
              items = state.filteredItems;
            } else if (state is HomeStateLoadingMore) {
              items = state.homeItems;
              isLoadingMore = true;
            }

            if (items != null && items.isNotEmpty) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: items.length + (isLoadingMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index >= items!.length) {
                          return const Center(
                              child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: CupertinoActivityIndicator(),
                          ));
                        }
                        return PrayerTileWidget(homeEntity: items[index],);
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: Text("No items found"));
            }
          } else if (state is HomeStateError) {
            return Center(child: Column(
              children: [
                Text("Error: ${state.dioException?.message ?? 'Unknown error'}"),
                const SizedBox(height: 2,),
                ElevatedButton(onPressed: (){

                  context.read<HomeBloc>().add(const GetItems());
                }, child: const Text("Retry")),
              ],
            ));
          } else {
            return const Center(child: Text("No items found"));
          }
        },
      ),
    );
  }
}
