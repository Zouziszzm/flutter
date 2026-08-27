---
title: Lumen
subtext: Local-first spaced-repetition for iOS and macOS — import Anki decks, study with FSRS, Flutter + Drift/SQLite.
order: 1
portfolioMode: summary-collapsible
detailsCollapsed: true
date: Jan 2026
stack: [Flutter, Dart, Drift, SQLite, FSRS]
extent: [Develop]
contribution: Solo Developer
category: Personal
relatedProjects:
  - id: rust--lumen
    label: Rust
    role: backend
  - id: tauri--lumen
    label: Tauri
    role: frontend
---

# Lumen

## Portfolio

**Lumen** (Flutter) is the mobile and cross-platform companion to the Tauri Mac app — same product vision, native Flutter UI. Import Anki `.apkg` / `.colpkg` files, study with **FSRS**, and keep everything local on device.

The app uses **Riverpod** for state, **Drift** over SQLite for persistence, and the Dart **fsrs** package for scheduling. Cards support audio and video via `just_audio` and `video_player`. Drag-and-drop import on macOS, file picker on iOS.

Study flow: Today or a deck → Study. Space shows the answer. `1`–`4` rate Again / Hard / Good / Easy. Browse lets you search and suspend cards. Scheduling starts fresh after import in v1.

Independent Anki package reader — no Anki source code included.

### Quick start

```bash
flutter pub get
dart run build_runner build
flutter run -d macos
```

iPhone: plug in device, trust certificate, then `flutter run --release -d ios`.

## Development

### Setup

1. Install [Xcode](https://developer.apple.com/xcode/) and Flutter (`brew install --cask flutter`).
2. From this directory:

```bash
flutter pub get
dart run build_runner build
```

### Run

```bash
flutter run -d macos
```

```bash
export DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer
flutter run --release -d ios
```

### Use

- **Import:** drag `.apkg` onto the Mac window, or Import in the sidebar
- **Study:** Today or a deck → Study
- **Add:** ⌘N for a Basic card
- **Browse:** right-click a deck to search and suspend cards

**Stack:** Flutter, Dart 3.5+, Riverpod, Drift, sqlite3, fsrs, archive, just_audio, video_player.
