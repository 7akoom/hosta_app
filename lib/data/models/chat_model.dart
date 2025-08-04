class ChatModel {
  final String id;
  final String userId;
  final String providerId;
  final String serviceId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;
  final List<MessageModel> messages;

  ChatModel({
    required this.id,
    required this.userId,
    required this.providerId,
    required this.serviceId,
    required this.createdAt,
    required this.updatedAt,
    this.isActive = true,
    this.messages = const [],
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      providerId: json['provider_id'] ?? '',
      serviceId: json['service_id'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
      isActive: json['is_active'] ?? true,
      messages: json['messages'] != null 
          ? (json['messages'] as List).map((msg) => MessageModel.fromJson(msg)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'provider_id': providerId,
      'service_id': serviceId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_active': isActive,
      'messages': messages.map((msg) => msg.toJson()).toList(),
    };
  }

  ChatModel copyWith({
    String? id,
    String? userId,
    String? providerId,
    String? serviceId,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
    List<MessageModel>? messages,
  }) {
    return ChatModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      providerId: providerId ?? this.providerId,
      serviceId: serviceId ?? this.serviceId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      messages: messages ?? this.messages,
    );
  }
}

class MessageModel {
  final String id;
  final String chatId;
  final String senderId;
  final String senderType; // 'user' or 'provider'
  final String content;
  final DateTime timestamp;
  final bool isRead;
  final String? attachmentUrl;
  final String? attachmentType;

  MessageModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.senderType,
    required this.content,
    required this.timestamp,
    this.isRead = false,
    this.attachmentUrl,
    this.attachmentType,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] ?? '',
      chatId: json['chat_id'] ?? '',
      senderId: json['sender_id'] ?? '',
      senderType: json['sender_type'] ?? 'user',
      content: json['content'] ?? '',
      timestamp: DateTime.parse(json['timestamp'] ?? DateTime.now().toIso8601String()),
      isRead: json['is_read'] ?? false,
      attachmentUrl: json['attachment_url'],
      attachmentType: json['attachment_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chat_id': chatId,
      'sender_id': senderId,
      'sender_type': senderType,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
      'is_read': isRead,
      'attachment_url': attachmentUrl,
      'attachment_type': attachmentType,
    };
  }

  MessageModel copyWith({
    String? id,
    String? chatId,
    String? senderId,
    String? senderType,
    String? content,
    DateTime? timestamp,
    bool? isRead,
    String? attachmentUrl,
    String? attachmentType,
  }) {
    return MessageModel(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      senderId: senderId ?? this.senderId,
      senderType: senderType ?? this.senderType,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
      attachmentUrl: attachmentUrl ?? this.attachmentUrl,
      attachmentType: attachmentType ?? this.attachmentType,
    );
  }
} 