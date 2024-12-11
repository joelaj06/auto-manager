build_junat:
	flutter build apk --release --split-per-abi --flavor junat

get:
	flutter pub get

clean:
	flutter clean

models:
	dart run build_runner build --delete-conflicting-outputs

run_launcher_icon_junat:
	dart run icons_launcher:create --flavor junat

run_native_splash_junat:
	dart run flutter_native_splash:create --path=native_splash_junat.yml --flavor junat
