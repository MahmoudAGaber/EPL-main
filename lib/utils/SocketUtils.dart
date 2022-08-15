

import 'package:socket_io_client/socket_io_client.dart' as IO;
class SocketUtils {
  static String _connectUrl = 'https://live.eplworld.com:3000';

  //EVENTS
  static const String _ON_MESSAGE_RECEIVED = "message";
  IO.Socket _socket;



  initSocket() {
    _socket = IO.io(_connectUrl, <String, dynamic>{
      'transports': ['websocket']
    });
  }



  connectToSocket() {
    if (null == _socket) {
      return;
    }
    _socket.connect();
  }

  setOnconnectListener(Function onConnect) {
    _socket.onConnect((data) {
      onConnect(data);
    });
  }

  setOnconnectionTimeOutListener(Function onConnectionTimeout) {
    _socket.onConnectTimeout((data) {
      onConnectionTimeout(data);
    });
  }

  setOnConnectionErrorListener(Function onConnectionError) {
    _socket.onConnectError((data) {
      onConnectionError(data);
    });
  }

  setOnErrorListener(Function onError) {
    _socket.onError((data) {
      onError(data);
    });
  }

  setOnDisconnectListener(Function onDisconnect) {
    _socket.onDisconnect((data) {
      onDisconnect(data);
    });
  }

  closeConnection() {
    if (null != _socket) {
      _socket.disconnect();
    }
  }

  setOnMessageReceived(Function onMessageReceived) {
    if (null == onMessageReceived) {
      return;
    }
    _socket.on(_ON_MESSAGE_RECEIVED, (data) {
      onMessageReceived(data);
    });
  }

}