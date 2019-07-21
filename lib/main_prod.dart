import './constants/constants.dart';
import './main.dart';

void main(){
  Constants.setEnvironment(Environment.DEV);
  mainDelegate();
}