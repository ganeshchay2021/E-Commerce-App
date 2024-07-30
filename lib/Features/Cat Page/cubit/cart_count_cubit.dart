import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myecomapp/Features/Cat%20Page/resources/cart_repository.dart';

class CartCountCubit extends Cubit<int> {
  final CartRepository cartRepository;
  CartCountCubit({required this.cartRepository}) : super(0);

  cartCount() async {
    final result = await cartRepository.cartCount();
    result.fold((error) => null, (data) => emit(data));
  }

  countIncrement(){
    emit(state+1);
  }

  countDecrement(){
    emit(state-1);
  }

  countClear(){
    emit(0);
  }
}
