import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  Controller controller = Get.put<Controller>(Controller());
  testWidgets("GetxController smoke test", (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Column(
          children: [
            Obx(
              () => Column(children: [
                Text(
                  'Count: ${controller.counter.value}',
                ),
                Text(
                  'Double: ${controller.doubleNum.value}',
                ),
                Text(
                  'String: ${controller.string.value}',
                ),
                Text(
                  'List: ${controller.list.length}',
                ),
                Text(
                  'Bool: ${controller.boolean.value}',
                ),
                Text(
                  'Map: ${controller.map.value.length}',
                ),
                FlatButton(
                  child: Text("increment"),
                  onPressed: () => controller.increment(),
                ),
                obx(() => Text(
                      'Obx: ${controller.map.value.length}',
                    ))
              ]),
            ),
          ],
        ),
      ),
    );

    expect(find.text("Count: 0"), findsOneWidget);
    expect(find.text("Double: 0.0"), findsOneWidget);
    expect(find.text("String: string"), findsOneWidget);
    expect(find.text("Bool: true"), findsOneWidget);
    expect(find.text("List: 0"), findsOneWidget);
    expect(find.text("Map: 0"), findsOneWidget);
    expect(find.text("Obx: 0"), findsOneWidget);

    Controller.to.increment();

    await tester.pump();

    expect(find.text("Count: 1"), findsOneWidget);

    await tester.tap(find.text('increment'));

    await tester.pump();

    expect(find.text("Count: 2"), findsOneWidget);
  });
}

class Controller extends GetxController {
  static Controller get to => Get.find();

  var counter = 0.obs;
  var doubleNum = 0.0.obs;
  var string = "string".obs;
  var list = [].obs;
  var map = {}.obs;
  var boolean = true.obs;

  void increment() {
    counter.value++;
  }
}
