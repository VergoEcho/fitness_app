import 'package:bloc/bloc.dart';

class SearchCubit extends Cubit<String> {
  SearchCubit() : super('');

  void update(String search) {
    emit(search);
  }

  void clear() {
    emit('');
  }
}
