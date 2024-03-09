import 'package:test/test.dart';

import 'package:euc/euc.dart';
import 'package:euc/jis.dart';

main() {
  group('EucJP()', () {
    test('.encode()', () {
      expect(EucJP().encode("おはよう世界"),
          equals([164, 170, 164, 207, 164, 232, 164, 166, 192, 164, 179, 166]));
    });

    test('.decode()', () {
      expect(
          EucJP().decode(
              [164, 170, 164, 207, 164, 232, 164, 166, 192, 164, 179, 166]),
          equals("おはよう世界"));
    });

    test('.encoder.bind()', () async {
      final input = () async* {
        yield "おはよ";
        yield "う世界";
      }();
      expect(
          await EucJP()
              .encoder
              .bind(input)
              .fold<List<int>>([], (previous, element) => previous + element),
          equals([164, 170, 164, 207, 164, 232, 164, 166, 192, 164, 179, 166]));
    });

    test('.decodeStream()', () async {
      final input = () async* {
        yield [164, 170, 164, 207, 164];
        yield [232, 164, 166, 192, 164, 179];
        yield [166];
      }();
      expect(await EucJP().decodeStream(input), equals("おはよう世界"));
    });
  });

  group('ShiftJIS()', () {
    test('.encode()', () {
      expect(ShiftJIS().encode("おはよう世界"),
          equals([130, 168, 130, 205, 130, 230, 130, 164, 144, 162, 138, 69]));
    });

    test('.decode()', () {
      expect(
          ShiftJIS().decode(
              [130, 168, 130, 205, 130, 230, 130, 164, 144, 162, 138, 69]),
          equals("おはよう世界"));
    });

    test('issue #5', () {
      expect(ShiftJIS().decode([142, 82, 250, 177, 32, 149, 113, 142, 247]),
          equals('山﨑 敏樹'));
    });

    test('Windows-31J Round Trip', () {
      final f = (text) {
        final cs = ShiftJIS();
        expect(cs.decode(cs.encode(text)), text);
      };
      f('ⅰⅱⅲⅳⅴⅵⅶⅷⅸⅹ￤＇＂'
          '纊褜鍈銈蓜俉炻昱棈鋹曻彅丨仡仼伀伃伹佖侒侊侚侔俍偀倢俿倞偆偰偂傔僴'
          '僘兊兤冝冾凬刕劜劦勀勛匀匇匤卲厓厲叝﨎咜咊咩哿喆坙坥垬埈埇﨏塚增墲'
          '夋奓奛奝奣妤妺孖寀甯寘寬尞岦岺峵崧嵓﨑嵂嵭嶸嶹巐弡弴彧德忞恝悅悊惞'
          '惕愠惲愑愷愰憘戓抦揵摠撝擎敎昀昕昻昉昮昞昤晥晗晙晴晳暙暠暲暿曺朎朗'
          '杦枻桒柀栁桄棏﨓楨﨔榘槢樰橫橆橳橾櫢櫤毖氿汜沆汯泚洄涇浯涖涬淏淸淲'
          '淼渹湜渧渼溿澈澵濵瀅瀇瀨炅炫焏焄煜煆煇凞燁燾犱犾猤猪獷玽珉珖珣珒琇'
          '珵琦琪琩琮瑢璉璟甁畯皂皜皞皛皦益睆劯砡硎硤硺礰礼神祥禔福禛竑竧靖竫'
          '箞精絈絜綷綠緖繒罇羡羽茁荢荿菇菶葈蒴蕓蕙蕫﨟薰蘒﨡蠇裵訒訷詹誧誾諟'
          '諸諶譓譿賰賴贒赶﨣軏﨤逸遧郞都鄕鄧釚釗釞釭釮釤釥鈆鈐鈊鈺鉀鈼鉎鉙鉑'
          '鈹鉧銧鉷鉸鋧鋗鋙鋐﨧鋕鋠鋓錥錡鋻﨨錞鋿錝錂鍰鍗鎤鏆鏞鏸鐱鑅鑈閒隆﨩'
          '隝隯霳霻靃靍靏靑靕顗顥飯飼餧館馞驎髙髜魵魲鮏鮱鮻鰀鵰鵫鶴鸙黑'
          'ⅠⅡⅢⅣⅤⅥⅦⅧⅨⅩ№℡㈱'
          '①②③④⑤⑥⑦⑧⑨⑩⑪⑫⑬⑭⑮⑯⑰⑱⑲⑳'
          '㍉㌔㌢㍍㌘㌧㌃㌶㍑㍗㌍㌦㌣㌫㍊㌻'
          '㎜㎝㎞㎎㎏㏄㎡㍻〝〟㏍'
          '㊤㊥㊦㊧㊨㈲㈹㍾㍽㍼∮∑∟⊿'
          '￢∵≒≡∫√⊥∠∩∪');
    });

    test('.encoder.bind()', () async {
      final input = () async* {
        yield "おはよ";
        yield "う世界";
      }();
      expect(
          await ShiftJIS()
              .encoder
              .bind(input)
              .fold<List<int>>([], (previous, element) => previous + element),
          equals([130, 168, 130, 205, 130, 230, 130, 164, 144, 162, 138, 69]));
    });

    test('.decodeStream()', () async {
      final input = () async* {
        yield [130, 168, 130, 205, 130];
        yield [230, 130, 164, 144, 162, 138];
        yield [69];
      }();
      expect(await ShiftJIS().decodeStream(input), equals("おはよう世界"));
    });
  });
}
