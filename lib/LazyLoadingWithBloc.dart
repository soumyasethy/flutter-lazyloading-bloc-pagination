import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/data/data_bloc.dart';
import 'blocs/data/data_event.dart';
import 'blocs/data/data_state.dart';

class LazyLoadingWithBloc extends StatefulWidget {
  @override
  _LazyLoadingWithBlocState createState() => _LazyLoadingWithBlocState();
}

class _LazyLoadingWithBlocState extends State<LazyLoadingWithBloc> {
  ScrollController _scrollController = ScrollController();
  final DataBloc dataBloc = DataBloc();

  @override
  void initState() {
    super.initState();
    dataBloc.add(DataLoad());
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  void _getMoreData() {
    print("load more date...");
    dataBloc.add(DataLoadMore());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lazy Loading with Blocs"),
      ),
      body: BlocBuilder(
        bloc: dataBloc,
        builder: (context, state) {
          if (state is DataLoaded)
            return ListView.builder(
              controller: _scrollController,
              itemExtent: 80,
              itemBuilder: (context, i) {
                if (i == state.myList.length) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListTile(
                  title: Text(state.myList[i]),
                );
              },
              itemCount: state.myList.length + 1,
            );
          return Container();
        },
      ),
    );
  }
}
