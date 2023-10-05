# Flutter GPT Voice Assistant app

A Flutter application that uses OpenAI's GPT-3.5 Turbo to create a voice assistant that can take voice input and respond to it. It can also generate images using Dall-E.

## Features

- **Voice Interaction**: Simply speak to your virtual assistant to get answers and perform tasks.
- **OpenAI Integration**: Harness the power of OpenAI's GPT-3.5 Turbo for intelligent responses.
- **Dall-E Integration**: Get creative with your personal assistant, powered by Dall-E's image generation capabilities.
- **Contextual Awareness**: It will remember your previous conversations and use them to provide more relevant responses.
- **Smart Voice Assistant**: Seamlessly switch between AI models for the best user experience.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Installation

After cloning this repository, migrate to `gpt_voice_assistant_app
` folder.

create `.env` file at the root of your folder and add the following lines:

```bash
  OPENAI_API_KEY=your_api_key
```

you can get your api key from [here](https://platform.openai.com/account/api-keys)

note that you need to have an account on [openai](https://beta.openai.com/) to get an api key.
and as of september 2023, you need to have credit balance to use the api.

Finally run the following commands to run your app:

```bash
  flutter pub get
  flutter run # (connect your physical device via usb with usb debugging enabled)
```

## Screenshots

<img src="https://github.com/jagtap-suraj/gpt_voice_assistant_app/assets/89206671/3dc68ad2-1768-4226-bcf6-0aad4fb70644" width="200">
<img src="https://github.com/jagtap-suraj/gpt_voice_assistant_app/assets/89206671/3d9ed0cf-99a7-4652-8aa1-26dea9220b1c" width="200">
<img src="https://github.com/jagtap-suraj/gpt_voice_assistant_app/assets/89206671/9e8f68e7-8dce-486e-806f-79e83976d40e" width="200">
<img src="https://github.com/jagtap-suraj/gpt_voice_assistant_app/assets/89206671/3e3772f0-f21b-4dc2-a81b-b96c398fcce8" width="200">

special thanks to [Rivaan Ranawat](https://www.youtube.com/@RivaanRanawat)
Reference tutorial [link](https://youtu.be/Q_pz4xFow3Q?si)
