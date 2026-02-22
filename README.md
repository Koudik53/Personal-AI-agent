# 🤖 Personal AI Agent — Android App

> A powerful, privacy-first AI assistant for Android that understands natural language commands in **Hindi and English** and controls your phone.

---

## 📱 App Overview

**Personal AI Agent** lets you control your Android phone using natural language. Type or speak commands like:
- *"WhatsApp kholo"* → Opens WhatsApp
- *"YouTube pe cooking videos search karo"* → Searches YouTube
- *"Set alarm at 7 AM"* → Sets an alarm
- *"Call 9876543210"* → Opens the dialer
- *"Google par weather search karo"* → Searches browser

The AI understands your intent, converts it to a structured action, and executes it — all **without any backend server**. Your API key is stored encrypted on your device only.

---

## 🏗️ Project Structure

```
PersonalAIAgent/
├── app/
│   └── src/main/
│       ├── AndroidManifest.xml
│       └── java/com/personalaiagent/
│           ├── MainActivity.kt                    # Entry point
│           ├── model/
│           │   └── Models.kt                      # Data models, AIAction, etc.
│           ├── data/
│           │   ├── SecureStorage.kt               # Encrypted API key storage
│           │   └── AIRepository.kt                # AI API communication
│           ├── service/
│           │   ├── ActionExecutor.kt              # Executes device actions
│           │   └── VoiceService.kt                # STT + TTS
│           ├── viewmodel/
│           │   ├── MainViewModel.kt               # Main screen state
│           │   └── SettingsViewModel.kt           # Settings screen state
│           └── ui/
│               ├── navigation/
│               │   └── AppNavigation.kt           # Nav graph
│               ├── screens/
│               │   ├── MainScreen.kt              # Main chat UI
│               │   └── SettingsScreen.kt          # API key config
│               ├── components/
│               │   └── Components.kt              # Reusable composables
│               └── theme/
│                   ├── Theme.kt                   # Dark theme colors
│                   └── Typography.kt              # Text styles
│   └── res/
│       └── values/
│           ├── strings.xml
│           └── themes.xml
├── build.gradle
└── settings.gradle
```

---

## 🚀 Features

### ✅ Phase 1 (Implemented)

| Feature | Description |
|---------|-------------|
| 🎙️ Voice Input | Speech-to-text with Hindi + English support |
| 🔊 Voice Output | TTS reads AI responses aloud |
| 📱 Open Apps | Launch any installed app by name |
| ▶️ YouTube Search | Search YouTube directly |
| 🌐 Browser Search | Google search via browser |
| 📞 Dial Numbers | Open dialer with number |
| 💬 Draft SMS | Open SMS with pre-filled content |
| ⏰ Set Alarm | Create alarms via AlarmClock API |
| 🔔 Set Reminder | Create reminders/events |
| 🔐 Secure API Key | AES-256 encrypted storage via Android Keystore |
| ⚠️ Confirmation Dialog | User must confirm calls/SMS before execution |
| 📋 Activity Log | Full history of executed commands |
| 🌙 Dark Mode | Sleek dark UI by default |

### 🔮 Phase 2 (Architecture Ready)

- Accessibility Service for advanced automation
- Screen content reading
- Auto-typing and screen interaction
- App usage analytics
- Multi-language expansion

---

## 🔌 Supported AI Providers

| Provider | Models | Get API Key |
|----------|--------|-------------|
| **OpenAI** | GPT-4o-mini, GPT-4o, GPT-3.5-turbo | platform.openai.com |
| **Anthropic** | Claude Haiku, Sonnet, Opus | console.anthropic.com |
| **Google** | Gemini Pro | makersuite.google.com |
| **Groq** | Llama3, Mixtral (free tier!) | console.groq.com |

> 💡 **Tip:** Start with **Groq** — it's free, very fast, and works great for this use case.

---

## 🔒 Privacy & Security

- ✅ **No backend server** — App talks directly to AI provider
- ✅ **Encrypted storage** — API keys stored with AES-256-GCM via Android Keystore
- ✅ **No data collection** — Nothing sent to any third party except your AI provider
- ✅ **On-device processing** — All logic runs locally
- ✅ **Confirmation required** — Calls and SMS need explicit user approval

---

## 🛠️ How It Works

```
User Input (text/voice)
        ↓
  VoiceService (STT)
        ↓
  MainViewModel
        ↓
  AIRepository.processCommand()
        ↓
  AI Provider API (user's key)
        ↓
  Parse JSON Response → AIAction
        ↓
  [Confirmation if sensitive]
        ↓
  ActionExecutor.execute()
        ↓
  Device Action (open app, dial, etc.)
        ↓
  VoiceService.speak() + Activity Log
```

---

## ⚙️ Setup & Build

### Requirements
- Android Studio Hedgehog (2023.1.1) or newer
- Android SDK 34
- Kotlin 1.9.10
- Min Android: API 26 (Android 8.0)

### Build Steps

```bash
# 1. Clone / open project in Android Studio
# 2. Sync Gradle dependencies
# 3. Build & run on device/emulator (API 26+)
```

### First Time Setup

1. Open app → tap ⚙️ Settings
2. Select your AI Provider (try Groq for free!)
3. Paste your API key
4. Tap **Test API Key** to verify
5. Tap **Save Settings**
6. Return to main screen and start commanding!

---

## 🧩 Adding New Actions

To add a new action type:

1. **Add constant** in `ActionTypes` object in `Models.kt`:
   ```kotlin
   const val MY_NEW_ACTION = "my_new_action"
   ```

2. **Update AI system prompt** in `AIRepository.kt` to teach the AI about the new action.

3. **Add executor** in `ActionExecutor.kt`:
   ```kotlin
   ActionTypes.MY_NEW_ACTION -> myNewAction(action)
   ```

4. **Add icon** in `getActionIcon()` in `MainScreen.kt`.

---

## 📋 JSON Action Format

The AI always returns structured JSON like this:

```json
{
  "action": "open_app",
  "target": "WhatsApp",
  "query": "",
  "extras": {},
  "response": "WhatsApp खोल रहा हूं!"
}
```

```json
{
  "action": "set_alarm",
  "target": "",
  "query": "Morning Alarm",
  "extras": { "hour": "7", "minute": "30" },
  "response": "Setting alarm for 7:30 AM!"
}
```

---

## 🎨 UI Design

- **Default:** Dark mode with purple accent (`#7C4DFF`)
- **Framework:** Jetpack Compose with Material3
- **Layout:** Single-column with bottom input bar
- **Activity log:** Reverse-chronological card list
- **Animations:** Pulse effect on mic, smooth transitions

---

## 🔮 Future Expansion: Accessibility Mode

To enable advanced screen automation (typing, clicking, reading screen content), add an Accessibility Service:

```kotlin
// In AndroidManifest.xml:
<service
    android:name=".service.AgentAccessibilityService"
    android:permission="android.permission.BIND_ACCESSIBILITY_SERVICE">
    <intent-filter>
        <action android:name="android.accessibilityservice.AccessibilityService"/>
    </intent-filter>
    <meta-data
        android:name="android.accessibilityservice"
        android:resource="@xml/accessibility_service_config"/>
</service>
```

This unlocks: screen reading, auto-fill, UI navigation, app content extraction — enabling true Siri/Google Assistant level automation.

---

## 📦 Dependencies

```gradle
// Core Compose + Material3
// Navigation Compose
// EncryptedSharedPreferences (Security Crypto)
// OkHttp + Retrofit (API calls)
// Gson (JSON parsing)
// Accompanist Permissions
// Kotlin Coroutines
// Core Splash Screen
```

---

## 📜 License

MIT License — Free to use, modify, and distribute.

---

*Built with ❤️ for the future of AI-powered mobile assistants.*
