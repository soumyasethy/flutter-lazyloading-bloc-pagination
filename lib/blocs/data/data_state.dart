abstract class DataState {}

class InitialDataState extends DataState {}

class DataLoading extends DataState {}

class DataLoaded extends DataState {
  final List<dynamic> myList;

  DataLoaded(this.myList);
}
