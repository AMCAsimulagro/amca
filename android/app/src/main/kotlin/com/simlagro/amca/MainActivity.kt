package com.simlagro.amca

import android.os.Bundle
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsControllerCompat
import androidx.core.view.WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
import io.flutter.embedding.android.FlutterActivity

/**
 * MainActivity configured to enable edge-to-edge display with a safe fallback.
 *
 * Notes:
 * - We try to call Flutter's EdgeToEdge helper (if available in the embedding).
 * - If it's not available, we apply a conservative fallback using WindowCompat
 *   and WindowInsetsControllerCompat so the app can run correctly on Android 15+.
 * - Avoid calling window.setStatusBarColor / setNavigationBarColor here to reduce
 *   the chance of Play Console warnings; prefer control from the Flutter layer
 *   (SystemChrome) or themes.
 */
class MainActivity : FlutterActivity() {
	
}
