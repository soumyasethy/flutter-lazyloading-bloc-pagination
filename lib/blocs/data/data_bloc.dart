import 'dart:async';

import 'package:bloc/bloc.dart';

import './data_event.dart';
import './data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  List myList;
  int initLoadCount = 10;
  int loadMoreCount = 0;
  int loadedLastIndex = 0;

  @override
  DataState get initialState => InitialDataState();

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    if (event is DataLoad) {
      yield DataLoading();
      myList = List.generate(initLoadCount, (i) => "Item : ${i + 1}");
      loadMoreCount = initLoadCount;
      yield DataLoaded(myList);
    }
    if (event is DataLoadMore) {
      loadedLastIndex += loadMoreCount;
      myList += List.generate(
          loadMoreCount, (i) => "Item : ${loadedLastIndex + i + 1}");

      yield DataLoaded(myList);
    }
  }
}
