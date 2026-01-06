import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../../core/props/search_props.dart';

/// ShadCN Search Input renderer.
///
/// Renders a search input with icon and clear button
/// following ShadCN design patterns.
class ShadcnSearch extends StatefulComponent {
  final SearchProps props;

  const ShadcnSearch(this.props);

  @override
  State<ShadcnSearch> createState() => _ShadcnSearchState();
}

class _ShadcnSearchState extends State<ShadcnSearch> {
  late String _value;

  @override
  void initState() {
    super.initState();
    _value = component.props.value ?? '';
  }

  @override
  void didUpdateComponent(ShadcnSearch oldComponent) {
    super.didUpdateComponent(oldComponent);
    if (component.props.value != null && component.props.value != _value) {
      _value = component.props.value!;
    }
  }

  void _handleChange(String value) {
    setState(() {
      _value = value;
    });
    component.props.onChanged?.call(value);
  }

  void _handleClear() {
    setState(() {
      _value = '';
    });
    component.props.onChanged?.call('');
  }

  void _handleSubmit() {
    component.props.onSubmitted?.call(_value);
  }

  @override
  Component build(BuildContext context) {
    final SearchProps props = component.props;

    final (height, fontSize, padding) = switch (props.size) {
      SearchSize.sm => ('36px', '0.875rem', '0.5rem 0.75rem'),
      SearchSize.md => ('40px', '1rem', '0.5rem 1rem'),
      SearchSize.lg => ('44px', '1.125rem', '0.75rem 1.25rem'),
    };

    final Map<String, String> styleBase = switch (props.style) {
      SearchStyle.standard => {
          'background-color': 'var(--background)',
          'border': '1px solid var(--border)',
        },
      SearchStyle.filled => {
          'background-color': 'var(--muted)',
          'border': '1px solid transparent',
        },
      SearchStyle.ghost => {
          'background-color': 'transparent',
          'border': 'none',
          'border-bottom': '1px solid var(--border)',
        },
    };

    return div(
      classes: 'arcane-search ${props.disabled ? 'disabled' : ''}',
      id: props.id,
      attributes: {
        ...?props.attributes,
      },
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': '0.5rem',
        'height': height,
        'padding': padding,
        'border-radius': props.style == SearchStyle.ghost ? '0' : '0.375rem',
        'opacity': props.disabled ? '0.5' : '1',
        'transition': 'all 150ms ease',
        ...styleBase,
      }),
      [
        // Search icon or spinner
        if (props.loading)
          _buildSpinner()
        else if (props.icon != null)
          props.icon!
        else if (props.showIcon)
          _buildSearchIcon(),

        // Input field
        input(
          type: InputType.text,
          classes: 'arcane-search-input',
          attributes: {
            'placeholder': props.placeholder,
            'value': _value,
            if (props.autofocus) 'autofocus': 'true',
            if (props.disabled) 'disabled': 'true',
          },
          styles: Styles(raw: {
            'flex': '1',
            'border': 'none',
            'background': 'transparent',
            'color': 'var(--foreground)',
            'font-size': fontSize,
            'outline': 'none',
            'min-width': '0',
          }),
          events: {
            'input': (event) {
              final dynamic target = event.target;
              if (target != null) {
                _handleChange((target as dynamic).value ?? '');
              }
            },
            'keydown': (event) {
              if ((event as dynamic).key == 'Enter') {
                _handleSubmit();
              }
            },
          },
        ),

        // Clear button
        if (props.showClear && _value.isNotEmpty)
          button(
            classes: 'arcane-search-clear',
            attributes: {'type': 'button'},
            styles: const Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'width': '20px',
              'height': '20px',
              'border-radius': '9999px',
              'background': 'var(--muted)',
              'color': 'var(--muted-foreground)',
              'border': 'none',
              'cursor': 'pointer',
              'transition': 'all 150ms ease',
            }),
            events: {
              'click': (event) => _handleClear(),
            },
            [text('x')],
          ),
      ],
    );
  }

  Component _buildSearchIcon() {
    // Simple search icon using raw HTML
    return RawText('''<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="color: var(--muted-foreground); flex-shrink: 0;"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>''');
  }

  Component _buildSpinner() {
    return span(
      classes: 'arcane-search-spinner',
      styles: const Styles(raw: {
        'display': 'inline-block',
        'width': '16px',
        'height': '16px',
        'border': '2px solid var(--border)',
        'border-right-color': 'var(--accent)',
        'border-radius': '9999px',
        'animation': 'arcane-spin 0.75s linear infinite',
        'flex-shrink': '0',
      }),
      [],
    );
  }
}
