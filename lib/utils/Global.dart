import 'SocketUtils.dart';


class G {
  static SocketUtils socketUtils;


  static initSocket() {
    if (null == socketUtils) {
      socketUtils = SocketUtils();
    }
  }
}