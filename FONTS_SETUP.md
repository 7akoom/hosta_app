# Font Setup Guide

To complete the font setup for the application, please follow these steps:

1. Download the required font files:

## Poppins Font
Download the following files from Google Fonts (https://fonts.google.com/specimen/Poppins):
- Poppins-Regular.ttf
- Poppins-Medium.ttf
- Poppins-SemiBold.ttf
- Poppins-Bold.ttf

## Mirza Font
Download the following files from Google Fonts (https://fonts.google.com/specimen/Mirza):
- Mirza-Regular.ttf
- Mirza-Medium.ttf
- Mirza-SemiBold.ttf
- Mirza-Bold.ttf

2. Place the downloaded font files in the following directory:
```
assets/fonts/
```

3. After placing the fonts, run:
```bash
flutter pub get
```

4. Clean and rebuild the app:
```bash
flutter clean
flutter pub get
flutter run
```

The app will now use:
- Poppins font for English text
- Mirza font for Arabic and Kurdish text

These fonts were chosen because:
- Poppins: Modern, clean, and highly readable font that works well for English UI text
- Mirza: Beautiful Arabic/Kurdish font that maintains readability while having a traditional feel that matches the cultural context