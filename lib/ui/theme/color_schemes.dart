/// {@category Styles}
/// Color scheme for the app's light theme.
library;
import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light, // Sets the theme's brightness to light.
  primary: Color(0xFF006E05), // Main color used in the application.
  onPrimary: Color(0xFFFFFFFF), // Text color over the main color.
  primaryContainer: Color(0xFF76FF65), // Container color over the main color.
  onPrimaryContainer: Color(0xFF002200), // Color of the text on the parent container.
  secondary: Color(0xFF006C4D), // Secondary color used in the application.
  onSecondary: Color(0xFFFFFFFF), // Text color over the secondary color.
  secondaryContainer: Color(0xFF00C913), // Container color over secondary color.
  onSecondaryContainer: Color(0xFF002115), // Color of the text on the secondary container.
  tertiary: Color(0xFF386569), // Tertiary color used in the application.
  onTertiary: Color(0xFFFFFFFF), // Text color over the tertiary color.
  tertiaryContainer: Color(0xFFBCEBEE), // Container color over tertiary color.
  onTertiaryContainer: Color(0xFF002022), // Color of the text on the tertiary container.
  error: Color(0xFFBA1A1A), // Color used to indicate errors.
  errorContainer: Color(0xFFFFDAD6), // Container color over error color.
  onError: Color(0xFFFFFFFF), // Text color over error color.
  onErrorContainer: Color(0xFF410002), // Text color on the application background.
  surface: Color(0xFFFCFDF6), //Application surface color.
  onSurface: Color(0xFF1A1C18), // Color of the text on the surface of the application.
  surfaceContainerHighest: Color(0xFFDFE4D8), // Surface color variant.
  onSurfaceVariant: Color(0xFF43483F), // Text color on surface variant.
  outline: Color(0xFF73796E), // Color used for the outlines.
  onInverseSurface: Color(0xFFF1F1EB), // Text color on the inverted surface.
  inverseSurface: Color(0xFF2F312D), // Inverted surface used in the application.
  inversePrimary: Color(0xFF3BE434), // Inverted primary color used in the application.
  shadow: Color(0xFF000000), // Color used for shadows.
  surfaceTint: Color(0xFF006E05), // Surface stain used in application.
  outlineVariant: Color(0xFFC3C8BC), // Contour variant used in the application.
  scrim: Color(0xFF000000), // Color used for the dark veil.
);
