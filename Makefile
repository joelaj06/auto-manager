build_apk:
	flutter build apk --release --split-per-abi

get:
	flutter pub get

clean:
	flutter clean

generate_models:
	dart run build_runner watch -d


launcher_icon:
	dart run icons_launcher:create

splash_screen:
	dart run flutter_native_splash:create --path=flutter_native_splash.yaml

.PHONY: build_apk get clean generate_models launcher_icon splash_screen