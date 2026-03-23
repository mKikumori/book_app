import 'package:book_app/views/app/create_book_view.dart';
import 'package:flutter/cupertino.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        bottom: false,
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      /*Navigator.of(context, rootNavigator: true).push(
                          CupertinoPageRoute(
                              builder: (context) =>
                                  const HomeEditView()));*/
                    },
                    child: const Text('Editar',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.activeBlue)),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                            CupertinoPageRoute(
                                builder: (context) => const CreateBookView()));
                      },
                      child: const Icon(CupertinoIcons.plus,
                          color: CupertinoColors.activeBlue)),
                ],
              )),
        ));
  }
}
