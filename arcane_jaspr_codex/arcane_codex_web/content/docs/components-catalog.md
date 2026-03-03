---
title: Component Catalog
description: Current Arcane component export surface and Shadcn-aligned catalog snapshot
layout: kb
---

# Component Catalog

This page is the source-of-truth snapshot of the current component surface as of **March 3, 2026**.

## Snapshot

- **Shadcn-aligned functional components:** `57`
- **Total exported component modules:** `84`
- **Foundation modules outside Shadcn cap:** `27`

## Shadcn-Aligned Components (57)

| Shadcn | Arcane Symbol | Source |
|---|---|---|
| `accordion` | `ArcaneAccordion` | `lib/component/interactive/accordion.dart` |
| `alert` | `ArcaneAlert` | `lib/component/view/alert.dart` |
| `alert-dialog` | `ArcaneAlertDialog` | `lib/component/dialog/confirm.dart` |
| `aspect-ratio` | `ArcaneAspectRatio` | `lib/component/layout/aspect_ratio.dart` |
| `avatar` | `ArcaneAvatar` | `lib/component/view/avatar.dart` |
| `badge` | `ArcaneStatusBadge` | `lib/component/feedback/status_badge.dart` |
| `breadcrumb` | `ArcaneBreadcrumbs` | `lib/component/navigation/breadcrumbs.dart` |
| `button` | `ArcaneButton` | `lib/component/input/button.dart` |
| `button-group` | `ArcaneButtonGroup` | `lib/component/layout/button_panel.dart` |
| `calendar` | `ArcaneCalendar` | `lib/component/input/calendar.dart` |
| `card` | `ArcaneCard` | `lib/component/card/card.dart` |
| `carousel` | `ArcaneCardCarousel` | `lib/component/collection/card_carousel.dart` |
| `chart` | `ArcaneChart` | `lib/component/data/chart.dart` |
| `checkbox` | `ArcaneCheckbox` | `lib/component/input/checkbox.dart` |
| `collapsible` | `ArcaneDisclosure` | `lib/component/interactive/disclosure.dart` |
| `combobox` | `ArcaneCombobox` | `lib/component/input/combobox.dart` |
| `command` | `ArcaneCommand` | `lib/component/dialog/command.dart` |
| `context-menu` | `ArcaneContextMenu` | `lib/component/menu/context_menu.dart` |
| `data-table` | `ArcaneDataTable` | `lib/component/data/data_table.dart` |
| `date-picker` | `ArcaneDatePicker` | `lib/component/input/date_picker.dart` |
| `dialog` | `ArcaneDialog` | `lib/component/dialog/dialog.dart` |
| `direction` | `ArcaneDirection` | `lib/component/layout/direction.dart` |
| `drawer` | `ArcaneDrawer` | `lib/component/layout/drawer.dart` |
| `dropdown-menu` | `ArcaneDropdownMenu` | `lib/component/menu/dropdown_menu.dart` |
| `empty` | `ArcaneEmptyState` | `lib/component/view/empty_state.dart` |
| `field` | `ArcaneField` | `lib/component/form/field.dart` |
| `hover-card` | `ArcaneHoverCard` | `lib/component/view/floating.dart` |
| `input` | `ArcaneTextInput` | `lib/component/input/text_input.dart` |
| `input-group` | `ArcaneInputGroup` | `lib/component/form/field_wrapper.dart` |
| `input-otp` | `ArcaneOtpInput` | `lib/component/input/otp_input.dart` |
| `item` | `ArcaneItem` | `lib/component/view/item.dart` |
| `kbd` | `ArcaneKbd` | `lib/component/view/kbd.dart` |
| `label` | `ArcaneLabel` | `lib/component/html/arcane_label.dart` |
| `menubar` | `ArcaneMenubar` | `lib/component/menu/menubar.dart` |
| `navigation-menu` | `ArcaneNavDropdown` | `lib/component/navigation/nav_dropdown.dart` |
| `pagination` | `ArcanePagination` | `lib/component/navigation/pagination.dart` |
| `popover` | `ArcanePopover` | `lib/component/dialog/popover.dart` |
| `progress` | `ArcaneProgressBar` | `lib/component/view/progress_bar.dart` |
| `radio-group` | `ArcaneRadioGroup` | `lib/component/input/radio_group.dart` |
| `resizable` | `ArcaneResizable` | `lib/component/layout/resizable.dart` |
| `scroll-area` | `ArcaneScrollArea` | `lib/component/layout/scroll_area.dart` |
| `select` | `ArcaneSelect` | `lib/component/input/text_input.dart` |
| `separator` | `ArcaneSeparator` | `lib/component/view/separator.dart` |
| `sheet` | `ArcaneSheet` | `lib/component/layout/sheet.dart` |
| `sidebar` | `ArcaneSidebar` | `lib/component/navigation/sidebar.dart` |
| `skeleton` | `ArcaneSkeleton` | `lib/component/view/skeleton.dart` |
| `slider` | `ArcaneSlider` | `lib/component/input/slider.dart` |
| `sonner` | `ArcaneSonner` | `lib/component/dialog/sonner.dart` |
| `spinner` | `ArcaneSpinner` | `lib/component/view/spinner.dart` |
| `switch` | `ArcaneToggleSwitch` | `lib/component/input/toggle_switch.dart` |
| `table` | `ArcaneStaticTable` | `lib/component/data/static_table.dart` |
| `tabs` | `ArcaneTabs` | `lib/component/layout/tabs.dart` |
| `textarea` | `ArcaneTextArea` | `lib/component/input/text_input.dart` |
| `toggle` | `ArcaneToggleButton` | `lib/component/input/cycle_button.dart` |
| `toggle-group` | `ArcaneToggleGroup` | `lib/component/input/toggle_group.dart` |
| `tooltip` | `ArcaneTooltip` | `lib/component/dialog/tooltip.dart` |
| `typography` | `ArcaneTypography` | `lib/component/typography/headline.dart` |

## Foundation Modules (Outside Shadcn Cap)

These exports are kept as low-level primitives/support modules and are intentionally outside the Shadcn functional cap.

### `collection` (1)

- `component/collection/infinite_carousel.dart`

### `html` (18)

- `component/html/arcane_button.dart`
- `component/html/arcane_cat_image.dart`
- `component/html/arcane_image.dart`
- `component/html/arcane_input.dart`
- `component/html/arcane_link.dart`
- `component/html/arcane_span.dart`
- `component/html/code_block.dart`
- `component/html/div.dart`
- `component/html/heading.dart`
- `component/html/lists.dart`
- `component/html/main_element.dart`
- `component/html/nav.dart`
- `component/html/paragraph.dart`
- `component/html/quote.dart`
- `component/html/section.dart`
- `component/html/side_content.dart`
- `component/html/svg.dart`
- `component/html/table.dart`

### `layout` (3)

- `component/layout/flow.dart`
- `component/layout/gutter.dart`
- `component/layout/scroll_rail.dart`

### `navigation` (1)

- `component/navigation/toc.dart`

### `promo` (1)

- `component/promo/promo.dart`

### `support` (1)

- `component/support/app.dart`

### `typography` (1)

- `component/typography/text.dart`

### `view` (1)

- `component/view/icon.dart`
