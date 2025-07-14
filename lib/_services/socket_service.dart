import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:riverpordmvvm/config.dart';

class SocketService {
  static final SocketService _instance = SocketService._internal();

  factory SocketService() {
    return _instance;
  }

  late final IO.Socket socket;
  bool _initialized = false;

  SocketService._internal();

  void init() {
    if (_initialized) return;
    socket = IO.io(Configs.socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });
    _initialized = true;
  }

  void emitSendMessage({
    required int chatId,
    required String message,
    required String createdAt,
    required int senderId,
    String type = 'text',
    String? fileUrl,
    int? messageId,
  }) {
    if (!_initialized) {
      init();
    }
    socket.emit('send_message', {
      'chatId': chatId,
      'message': message.trim(),
      'createdAt': createdAt,
      'senderId': senderId,
      'type': type,
      'fileUrl': fileUrl,
      'messageId': messageId,
    });

    socket.emit('new_message', {
      'chatId': chatId,
      'lastMessage': {
        'message': message.trim(),
        'createdAt': createdAt,
        'senderId': senderId,
        'type': type,
      }
    });
  }
}