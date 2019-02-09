import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp()); //One-line function

// StatefulWidget: Các widget cho phép thay đổi trong quá trình làm việc
// khi thuộc tính thay đổi (giống kiểu rerender bên react native)
class RandomEnglishWord extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RandomEnglishWordState();
    // Return về 1 state object có kiểu là lớp StatefulWidget này
    // Mỗi lần có gì thay đổi thì đoạn return này sẽ đc gọi lại
  }
}

// State object
// Luôn có đôi có cặp vs StatefulWidget
class RandomEnglishWordState extends State<RandomEnglishWord> {
  final _wordData = <WordPair>[];
  final _wordChecked =
      new Set<WordPair>(); // Set: Lớp dữ liệu không có các phần tử trùng lặp

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: ListView.builder(itemBuilder: (context, index) {
        if (index >= _wordData.length) {
          // State change here
          _wordData.addAll(generateWordPairs().take(10));
        }
        return _buildListItem(_wordData[index], index);
      } // Anonymous Function
          ),
    );
  }

  Widget _buildListItem(WordPair wordPair, int index) {
    final textColor = index % 2 == 0 ? Colors.blue : Colors.red;
    final isItemChecked = _wordChecked.contains(wordPair);
    // Tạo widget cho từng hàng
    return new ListTile(
      leading: new Text((index + 1).toString()), // Vị trí đầu item
      trailing: new Icon(isItemChecked
          ? Icons.check_box
          : Icons.check_box_outline_blank,
          color: textColor), // Vị trí cuối item
      title: new Text(wordPair.asPascalCase,
          style: new TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
          )),
      onTap: () {
        // Cứ lúc nào thực hiện hành động làm thay đổi props liên quan tới giao diện thì cho vào setState
        setState(() {
          isItemChecked
              ? _wordChecked.remove(wordPair)
              : _wordChecked.add(wordPair);
        });
      },
    ); // ListTile: Từng thành phần trong ListView
  }
}

//StatelessWidget: Các widget immutable, không thay đổi đc thuộc tính trong suốt quá trình
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "My 1st Flutter App",
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Flutter ListView Example'),
        ),
        body: new RandomEnglishWord(),
      ),
    );
  }
}
