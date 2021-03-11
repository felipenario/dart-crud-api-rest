# RESTful Crud Dart Api

This example handles HTTP requests.


## Testing locally

Run the `build_runner` to regenerate `bin/server.dart` from `lib/functions.dart` and to build `homework_controller.g.dart`

```shell
$ dart run build_runner build
[INFO] Generating build script completed, took 304ms
[INFO] Reading cached asset graph completed, took 46ms
[INFO] Checking for updates since last build completed, took 412ms
[INFO] Running build completed, took 2.2s
[INFO] Caching finalized dependency graph completed, took 28ms
[INFO] Succeeded after 2.3s with 1 outputs (1 actions)

```

Run it on your system:

OBS: To run on Windows make the changes pointed on: https://github.com/GoogleCloudPlatform/functions-framework-dart/pull/153/commits/b3236807d8ec592e4534d0cfdde68aea22ce9b0d

```shell
$ dart run bin/server.dart
Listening on :8080
```


