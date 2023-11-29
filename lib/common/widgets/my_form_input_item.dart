import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qulip/common/widgets/my_text.dart';
import 'package:qulip/common/widgets/my_textarea.dart';
import 'package:qulip/common/widgets/my_textfield.dart';

class MyFormInputItem extends StatelessWidget {
  const MyFormInputItem({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  final String title;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          title,
          fontSize: 16,
        ).paddingOnly(bottom: 10),
        child
      ],
    );
  }
}

class MyFormTextArea extends StatelessWidget {
  const MyFormTextArea({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return MyTextArea(
      controller: controller,
      keyboard: TextInputType.multiline,
      labelText: '',
      hintText: '',
      maxLines: 3,
    );
  }
}

class MyFormMultiChoice extends StatelessWidget {
  const MyFormMultiChoice({
    Key? key,
    required this.list,
    required this.selectedList,
  }) : super(key: key);

  final List<String> list;
  final List<String> selectedList;

  @override
  Widget build(BuildContext context) {
    final selected = selectedList.obs;

    void onChange(String item) {
      if (selected.contains(item)) {
        selected.remove(item);
      } else {
        selected.add(item);
      }
    }

    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 40,
      ),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final currentItem = list[index];
        return Obx(
          () => InkWell(
            onTap: () {
              onChange(currentItem);
            },
            child: Row(
              children: [
                Checkbox(
                  value: selected.contains(currentItem),
                  onChanged: (value) {
                    onChange(currentItem);
                  },
                ),
                //const SizedBox(width: 5.0),
                Flexible(
                  child: MyText(
                    currentItem,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MyCheckbox extends StatelessWidget {
  const MyCheckbox({
    Key? key,
    required this.isSelected,
    required this.text,
  }) : super(key: key);
  final RxBool isSelected;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: isSelected.value,
            onChanged: (bool? value) {
              isSelected.value = value ?? false;
            },
          ),
        ),
        MyText(
          text,
        )
      ],
    );
  }
}

class MyFormTextField extends StatelessWidget {
  const MyFormTextField({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: MyTextField(
        hintText: title,
        onChanged: (val) {},
      ),
    );
  }
}

class MyFormRadioButton extends StatelessWidget {
  const MyFormRadioButton({
    Key? key,
    required this.list,
    required this.selectedItem,
  }) : super(key: key);

  final List<String> list;
  final String selectedItem;

  @override
  Widget build(BuildContext context) {
    final selected = selectedItem.obs;
    void onChange(String item) {
      selected.value = item;
    }

    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 40,
      ),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final currentItem = list[index];
        return Obx(
          () => InkWell(
            onTap: () {
              onChange(currentItem);
            },
            child: Row(
              children: [
                SizedBox(
                  height: 24.0,
                  width: 24.0,
                  child: Radio(
                    value: selected.contains(currentItem),
                    onChanged: (value) {
                      onChange(currentItem);
                    },
                    groupValue: true,
                  ),
                ),
                const SizedBox(width: 10.0),
                Flexible(child: MyText(currentItem)),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MyFormWorkingHours extends StatelessWidget {
  MyFormWorkingHours({
    Key? key,
  }) : super(key: key);

  final List<String> days = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: days.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.zero,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 25,
                    alignment: Alignment.centerLeft,
                    color: Colors.grey.shade300,
                    child: MyText(days[index]).paddingOnly(left: 10),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey.shade400,
                  ),
                  Row(
                    children: const [
                      Expanded(
                        flex: 3,
                        child: MyText('Is Open?'),
                      ),
                      Expanded(
                        flex: 6,
                        child: MyFormRadioButton(
                          list: ['Yes', 'No'],
                          selectedItem: 'No',
                        ),
                      )
                    ],
                  ).paddingSymmetric(horizontal: 10),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey.shade300,
                  ),
                  Row(
                    children: const [
                      Expanded(flex: 3, child: MyText('Hours')),
                      Expanded(flex: 6, child: MyFormTextField(title: '')),
                    ],
                  ).paddingSymmetric(horizontal: 10, vertical: 5)
                ],
              ),
            ).paddingOnly(bottom: 15);
          },
        )
      ],
    );
  }
}
