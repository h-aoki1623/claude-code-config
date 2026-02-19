# React Native Patterns

> This file extends [common/patterns.md](../common/patterns.md) and [typescript/patterns.md](../typescript/patterns.md) with React Native specific content.

## Navigation

Use **Expo Router** (file-based routing) or **React Navigation** (stack-based):

```typescript
// Expo Router: file-based (app/ directory)
// app/(tabs)/home.tsx  → /home
// app/user/[id].tsx    → /user/:id

// React Navigation: stack-based
import { createNativeStackNavigator } from '@react-navigation/native-stack'

type RootStackParamList = {
  Home: undefined
  UserDetail: { userId: string }
}

const Stack = createNativeStackNavigator<RootStackParamList>()
```

## List Rendering

Use **FlashList** over FlatList/ScrollView for large lists:

```typescript
import { FlashList } from '@shopify/flash-list'

<FlashList
  data={items}
  renderItem={({ item }) => <ItemCard item={item} />}
  estimatedItemSize={80}
  keyExtractor={(item) => item.id}
/>
```

## Offline-First

Design for intermittent connectivity:

```typescript
import NetInfo from '@react-native-community/netinfo'

// 1. Local-first: read/write to local storage, sync when online
// 2. Queue mutations: store pending changes, flush on reconnect
// 3. Optimistic updates: update UI immediately, reconcile on sync
```

Storage options by use case:

| Use Case | Library |
|---|---|
| Key-value (fast, sync) | `react-native-mmkv` |
| Key-value (async) | `@react-native-async-storage/async-storage` |
| Structured data / queries | `WatermelonDB`, `Realm` |
| Sensitive data | `expo-secure-store`, `react-native-keychain` |

## OTA Updates

Use **Expo Updates** or **CodePush** for over-the-air JS bundle updates:

```typescript
import * as Updates from 'expo-updates'

async function checkForUpdate(): Promise<void> {
  try {
    const update = await Updates.checkForUpdateAsync()
    if (update.isAvailable) {
      await Updates.fetchUpdateAsync()
      // Consider: prompt user before reloading
      await Updates.reloadAsync()
    }
  } catch (error) {
    // Log but don't crash — updates are non-critical
    console.warn('Update check failed:', error)
  }
}
```

## Deep Linking

Configure deep links with URL scheme and universal links:

```typescript
// app.config.ts (Expo)
export default {
  scheme: 'myapp',
  ios: {
    associatedDomains: ['applinks:example.com'],
  },
  android: {
    intentFilters: [
      {
        action: 'VIEW',
        data: [{ scheme: 'https', host: 'example.com', pathPrefix: '/app' }],
      },
    ],
  },
}
```

## Platform Branching Pattern

```typescript
import { Platform } from 'react-native'

// For behavior differences
function getHapticFeedback(): void {
  if (Platform.OS === 'ios') {
    // iOS-specific haptic
  }
  // Android: no-op or different implementation
}

// For component differences: use .ios.tsx / .android.tsx file extensions
```

## Reference

- See skill: `react-native-best-practices` for performance patterns (FlashList, Reanimated, Turbo Modules)
- See skill: `ios-design` for Apple HIG compliance
- See skill: `android-design` for Material Design 3 compliance
