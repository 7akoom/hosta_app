import 'package:flutter/material.dart';
import 'package:hosta_app/data/models/chat_model.dart';
import 'package:hosta_app/data/models/provider_model.dart';

class ChatProvider extends ChangeNotifier {
  final List<ChatModel> _chats = [];
  ChatModel? _currentChat;
  bool _isLoading = false;
  String? _error;

  // Getters
  List<ChatModel> get chats => _chats;
  ChatModel? get currentChat => _currentChat;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Create or get existing chat with provider
  Future<ChatModel?> createOrGetChat(ProviderModel provider, String serviceId) async {
    try {
      _setLoading(true);
      
      // Check if chat already exists
      final existingChat = _chats.firstWhere(
        (chat) => chat.providerId == provider.id && chat.serviceId == serviceId,
        orElse: () => ChatModel(
          id: '',
          userId: '',
          providerId: '',
          serviceId: '',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      if (existingChat.id.isNotEmpty) {
        _currentChat = existingChat;
        notifyListeners();
        return existingChat;
      }

      // Create new chat
      final newChat = ChatModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: 'current_user_id', // TODO: Get from auth provider
        providerId: provider.id,
        serviceId: serviceId,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        messages: [
          // Add initial message
          MessageModel(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            chatId: DateTime.now().millisecondsSinceEpoch.toString(),
            senderId: 'current_user_id',
            senderType: 'user',
            content: 'مرحباً! أنا مهتم بخدمتك.',
            timestamp: DateTime.now(),
          ),
        ],
      );

      _chats.add(newChat);
      _currentChat = newChat;
      _setLoading(false);
      notifyListeners();
      
      return newChat;
    } catch (e) {
      _setError('Error creating chat: $e');
      return null;
    }
  }

  // Send message
  Future<bool> sendMessage(String content) async {
    if (_currentChat == null || content.trim().isEmpty) return false;

    try {
      final message = MessageModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        chatId: _currentChat!.id,
        senderId: 'current_user_id', // TODO: Get from auth provider
        senderType: 'user',
        content: content.trim(),
        timestamp: DateTime.now(),
      );

      // Add message to current chat
      final updatedMessages = List<MessageModel>.from(_currentChat!.messages)..add(message);
      _currentChat = _currentChat!.copyWith(
        messages: updatedMessages,
        updatedAt: DateTime.now(),
      );

      // Update chat in list
      final chatIndex = _chats.indexWhere((chat) => chat.id == _currentChat!.id);
      if (chatIndex != -1) {
        _chats[chatIndex] = _currentChat!;
      }

      notifyListeners();
      return true;
    } catch (e) {
      _setError('Error sending message: $e');
      return false;
    }
  }

  // Load chat messages
  Future<void> loadChatMessages(String chatId) async {
    try {
      _setLoading(true);
      
      // TODO: Load messages from API
      // For now, just find the chat in local list
      final chat = _chats.firstWhere(
        (chat) => chat.id == chatId,
        orElse: () => ChatModel(
          id: '',
          userId: '',
          providerId: '',
          serviceId: '',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      if (chat.id.isNotEmpty) {
        _currentChat = chat;
      }

      _setLoading(false);
      notifyListeners();
    } catch (e) {
      _setError('Error loading messages: $e');
    }
  }

  // Load user chats
  Future<void> loadUserChats() async {
    try {
      _setLoading(true);
      
      // TODO: Load chats from API
      // For now, keep existing chats
      
      _setLoading(false);
      notifyListeners();
    } catch (e) {
      _setError('Error loading chats: $e');
    }
  }

  // Mark message as read
  void markMessageAsRead(String messageId) {
    if (_currentChat == null) return;

    final messageIndex = _currentChat!.messages.indexWhere((msg) => msg.id == messageId);
    if (messageIndex != -1) {
      final updatedMessages = List<MessageModel>.from(_currentChat!.messages);
      updatedMessages[messageIndex] = updatedMessages[messageIndex].copyWith(isRead: true);
      
      _currentChat = _currentChat!.copyWith(messages: updatedMessages);
      
      // Update chat in list
      final chatIndex = _chats.indexWhere((chat) => chat.id == _currentChat!.id);
      if (chatIndex != -1) {
        _chats[chatIndex] = _currentChat!;
      }

      notifyListeners();
    }
  }

  // Clear current chat
  void clearCurrentChat() {
    _currentChat = null;
    notifyListeners();
  }

  // Private methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    if (loading) _error = null;
  }

  void _setError(String error) {
    _error = error;
    _isLoading = false;
    notifyListeners();
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
} 