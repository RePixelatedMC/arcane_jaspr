import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart'
    hide
        Color,
        Colors,
        ColorScheme,
        Gap,
        Padding,
        TextAlign,
        TextOverflow,
        Border,
        BorderRadius,
        BoxShadow,
        FontWeight;

import '../view/avatar.dart';

enum ChatStyle {
  bubbles,
  tiles,
}

/// Abstract message interface.
abstract class AbstractChatMessage {
  String get id;
  Component get messageWidget;
  DateTime get timestamp;
  String get senderId;
}

/// Abstract user interface.
abstract class AbstractChatUser {
  String get id;
  String get name;
  Component get avatar;
}

/// Chat provider interface.
abstract class ChatProvider<M extends AbstractChatMessage, U extends AbstractChatUser> {
  Stream<List<M>> streamLastMessages();
  Future<U> getUser(String id);
  Future<void> sendMessage(String text);
}

/// Chat screen component.
class ArcaneChatScreen<M extends AbstractChatMessage, U extends AbstractChatUser>
    extends StatefulComponent {
  final ChatStyle style;
  final ChatProvider<M, U> provider;
  final String currentUserId;
  final Component? header;
  final bool showInput;
  final String inputPlaceholder;
  final bool showTimestamps;
  final bool showAvatars;
  final Component? sendButton;
  final bool gutter;

  const ArcaneChatScreen({
    required this.provider,
    required this.currentUserId,
    this.style = ChatStyle.bubbles,
    this.header,
    this.showInput = true,
    this.inputPlaceholder = 'Type a message...',
    this.showTimestamps = true,
    this.showAvatars = true,
    this.sendButton,
    this.gutter = true,
    super.key,
  });

  @override
  State<ArcaneChatScreen<M, U>> createState() => _ChatScreenState<M, U>();

  @css
  static final List<StyleRule> styles = [
    css('.arcane-chat-input:focus').styles(raw: {
      'border-color': 'var(--accent)',
      'box-shadow': '0 0 0 2px hsl(var(--accent) / 0.1)',
    }),
    css('.arcane-chat-send:hover').styles(raw: {
      'background': 'hsl(var(--accent) / 0.9)',
    }),
  ];
}

class _ChatScreenState<M extends AbstractChatMessage, U extends AbstractChatUser>
    extends State<ArcaneChatScreen<M, U>> {
  List<M> _messages = [];
  String _inputValue = '';
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    await for (final messages in component.provider.streamLastMessages()) {
      setState(() {
        _messages = messages;
        _loading = false;
      });
      break;
    }
  }

  Future<void> _sendMessage() async {
    if (_inputValue.trim().isEmpty) return;
    await component.provider.sendMessage(_inputValue);
    setState(() => _inputValue = '');
    _loadMessages();
  }

  String _formatTimestamp(DateTime timestamp) {
    final hour = timestamp.hour > 12 ? timestamp.hour - 12 : timestamp.hour;
    final period = timestamp.hour >= 12 ? 'PM' : 'AM';
    return '${hour == 0 ? 12 : hour}:${timestamp.minute.toString().padLeft(2, '0')} $period';
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-chat-screen arcane-chat-${component.style.name}',
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'height': '100%',
        'background': 'var(--background)',
      }),
      [
        if (component.header != null) component.header!,
        div(
          classes: 'arcane-chat-messages',
          styles: Styles(raw: {
            'flex': '1',
            'overflow-y': 'auto',
            'padding': component.gutter ? '1rem' : '0',
            'display': 'flex',
            'flex-direction': 'column',
            'gap': '0.5rem',
          }),
          [
            if (_loading)
              const div(
                styles: Styles(raw: {
                  'display': 'flex',
                  'justify-content': 'center',
                  'padding': '2rem',
                  'color': 'var(--muted-foreground)',
                }),
                [Component.text('Loading messages...')],
              )
            else if (_messages.isEmpty)
              const div(
                styles: Styles(raw: {
                  'display': 'flex',
                  'justify-content': 'center',
                  'padding': '2rem',
                  'color': 'var(--muted-foreground)',
                }),
                [Component.text('No messages yet')],
              )
            else
              for (final message in _messages)
                _buildMessage(message),
          ],
        ),
        if (component.showInput)
          div(
            classes: 'arcane-chat-input-area',
            styles: const Styles(raw: {
              'padding': '1rem',
              'border-top': '1px solid var(--border)',
              'background': 'var(--card)',
            }),
            [
              div(
                styles: const Styles(raw: {
                  'display': 'flex',
                  'gap': '0.5rem',
                  'align-items': 'flex-end',
                }),
                [
                  textarea(
                    classes: 'arcane-chat-input',
                    attributes: {
                      'placeholder': component.inputPlaceholder,
                      'rows': '1',
                    },
                    styles: const Styles(raw: {
                      'flex': '1',
                      'padding': '10px 0.5rem',
                      'border': '1px solid var(--border)',
                      'border-radius': '0.5rem',
                      'background': 'var(--background)',
                      'color': 'var(--foreground)',
                      'font-size': '0.875rem',
                      'font-family': 'inherit',
                      'resize': 'none',
                      'outline': 'none',
                      'min-height': '40px',
                      'max-height': '120px',
                    }),
                    events: {
                      'input': (event) {
                        final dynamic target = event.target;
                        if (target != null) {
                          setState(() => _inputValue = target.value ?? '');
                        }
                      },
                      'keydown': (event) {
                        final dynamic e = event;
                        if (e.key == 'Enter' && !e.shiftKey) {
                          e.preventDefault();
                          _sendMessage();
                        }
                      },
                    },
                    [Component.text(_inputValue)],
                  ),
                  component.sendButton ??
                      button(
                        type: ButtonType.button,
                        classes: 'arcane-chat-send',
                        styles: const Styles(raw: {
                          'width': '40px',
                          'height': '40px',
                          'border': 'none',
                          'border-radius': '9999px',
                          'background': 'var(--accent)',
                          'color': 'var(--accent-foreground)',
                          'cursor': 'pointer',
                          'display': 'flex',
                          'align-items': 'center',
                          'justify-content': 'center',
                          'font-size': '1.125rem',
                          'transition': 'all 150ms ease',
                        }),
                        events: {
                          'click': (_) => _sendMessage(),
                        },
                        [const Component.text('\u27a4')],
                      ),
                ],
              ),
            ],
          ),
      ],
    );
  }

  Component _buildMessage(M message) {
    final isCurrentUser = message.senderId == component.currentUserId;

    return component.style == ChatStyle.bubbles
        ? _buildBubbleMessage(message, isCurrentUser)
        : _buildTileMessage(message, isCurrentUser);
  }

  Component _buildBubbleMessage(M message, bool isCurrentUser) {
    return div(
      classes: 'arcane-chat-message ${isCurrentUser ? 'sent' : 'received'}',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': isCurrentUser ? 'row-reverse' : 'row',
        'align-items': 'flex-end',
        'gap': '0.5rem',
      }),
      [
        if (component.showAvatars && !isCurrentUser)
          const ArcaneAvatar(
            initials: '?',
            size: AvatarSize.sm,
          ),
        div(
          styles: Styles(raw: {
            'max-width': '70%',
            'padding': '0.5rem 1rem',
            'border-radius': isCurrentUser
                ? '0.5rem 0.5rem 0.25rem 0.5rem'
                : '0.5rem 0.5rem 0.5rem 0.25rem',
            'background': isCurrentUser
                ? 'var(--accent)'
                : 'var(--muted)',
            'color': isCurrentUser
                ? 'var(--accent-foreground)'
                : 'var(--foreground)',
          }),
          [
            message.messageWidget,
            if (component.showTimestamps)
              div(
                styles: Styles(raw: {
                  'font-size': '0.75rem',
                  'opacity': '0.7',
                  'margin-top': '0.25rem',
                  'text-align': isCurrentUser ? 'right' : 'left',
                }),
                [Component.text(_formatTimestamp(message.timestamp))],
              ),
          ],
        ),
      ],
    );
  }

  Component _buildTileMessage(M message, bool isCurrentUser) {
    return div(
      classes: 'arcane-chat-tile',
      styles: const Styles(raw: {
        'display': 'flex',
        'gap': '0.5rem',
        'padding': '0.5rem',
        'border-radius': '0.375rem',
      }),
      [
        if (component.showAvatars)
          const ArcaneAvatar(
            initials: '?',
            size: AvatarSize.sm,
          ),
        div(
          styles: const Styles(raw: {
            'flex': '1',
            'min-width': '0',
          }),
          [
            div(
              styles: const Styles(raw: {
                'display': 'flex',
                'align-items': 'baseline',
                'gap': '0.5rem',
                'margin-bottom': '0.25rem',
              }),
              [
                span(
                  styles: const Styles(raw: {
                    'font-weight': '500',
                    'color': 'var(--foreground)',
                    'font-size': '0.875rem',
                  }),
                  [Component.text(isCurrentUser ? 'You' : 'User')],
                ),
                if (component.showTimestamps)
                  span(
                    styles: const Styles(raw: {
                      'font-size': '0.75rem',
                      'color': 'var(--muted-foreground)',
                    }),
                    [Component.text(_formatTimestamp(message.timestamp))],
                  ),
              ],
            ),
            message.messageWidget,
          ],
        ),
      ],
    );
  }
}

/// Simple chat message implementation.
class SimpleChatMessage implements AbstractChatMessage {
  @override
  final String id;

  final String content;

  @override
  final DateTime timestamp;

  @override
  final String senderId;

  const SimpleChatMessage({
    required this.id,
    required this.content,
    required this.timestamp,
    required this.senderId,
  });

  @override
  Component get messageWidget => Component.text(content);
}

/// Simple chat user implementation.
class SimpleChatUser implements AbstractChatUser {
  @override
  final String id;

  @override
  final String name;

  final String? imageUrl;
  final String? initials;

  const SimpleChatUser({
    required this.id,
    required this.name,
    this.imageUrl,
    this.initials,
  });

  @override
  Component get avatar => ArcaneAvatar(
        imageUrl: imageUrl,
        initials: initials ?? name.substring(0, 2).toUpperCase(),
        size: AvatarSize.sm,
      );
}
