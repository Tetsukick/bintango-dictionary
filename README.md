# Bintango Indonesian Dictionary web app
  
## Getting Started 🚀

You can go through this [Flutter Starter Pack](https://sadmansamee.github.io/flutter_starter_pack).

This project contains 3 flavors:

- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Production
$ flutter run --flavor production --target lib/main_production.dart
```

_\*Bintango Dictionary works on iOS, Android, and Web._

---


## Use MakeFile / Derry to avoid writing your own scripts.

You can run all these scripts manually or could use  [MakeFile](https://github.com/SimpleBoilerplates/Flutter/blob/master/makefile) / [Derry](https://pub.dev/packages/derry) and maintain a file, where you can define all those scripts and run in a very convinient way. All the scripts for this project is defined here [derry scripts](https://github.com/SimpleBoilerplates/Flutter/blob/master/derry.yaml) and [makefile scripts](https://github.com/SimpleBoilerplates/Flutter/blob/master/makefile)

Example: 

run `make watch` or `derry watch` instead of

```sh
flutter pub run build_runner watch --delete-conflicting-outputs
``` 

run `make build` or `derry build` instead of

```sh
flutter pub run build_runner build --delete-conflicting-outputs
``` 

or run `make build_apk_dev` or `derry build_apk_dev` instead of 

```sh
flutter build apk --flavor development -t lib/main_development.dart 
``` 
---

## Running Tests 🧪

To run all unit and widget tests use the following command:

```sh
$ flutter test --coverage --test-randomize-ordering-seed random
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```

---

## Working with Translations 🌐


### Adding Strings

1. To add a new localizable string, open the `app_en.arb` file at `assets/land/arb/en.json`.

```json
{
  "home" : "Home",
  "loading" : "Loading",
  "email" : "Email",
  "password" : "Password",
  "name" : "Name",
  "sign_in" : "Sign In",
  "sign_up" : "Sign Up"

}
```


2. After adding new 

```dart
import 'package:easy_localization/easy_localization.dart';

@override
Widget build(BuildContext context) {
  return Text("helloWorld".tr());
}
```

## License
[![CC0](http://mirrors.creativecommons.org/presskit/buttons/88x31/svg/cc-zero.svg)](https://creativecommons.org/publicdomain/zero/1.0/)

