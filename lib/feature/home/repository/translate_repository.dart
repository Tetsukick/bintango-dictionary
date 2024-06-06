import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';

import 'package:bintango_indonesian_dictionary/feature/home/model/tango_entity.dart';
import 'package:bintango_indonesian_dictionary/feature/home/model/translate_response.dart';
import 'package:bintango_indonesian_dictionary/feature/home/model/unregistered_tango_entity.dart';
import 'package:bintango_indonesian_dictionary/shared/http/api_provider.dart';
import 'package:bintango_indonesian_dictionary/shared/http/api_response.dart';
import 'package:collection/collection.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class TranslateRepositoryProtocol {
  Future<TranslateResponse> translate({
    required String text, required bool isSourceJapanese,});
}

final translateRepositoryProvider =
  Provider<TranslateRepository>(TranslateRepository.new);

class TranslateRepository implements TranslateRepositoryProtocol {
  TranslateRepository(this._ref);

  late final ApiProvider _api = _ref.read(apiProvider);
  final Ref _ref;

  @override
  Future<TranslateResponse> translate({
    required String text,
    required bool isSourceJapanese,
  }) async {
    final prompt = isSourceJapanese ?
    '日本語の例文「$text」をインドネシア語に翻訳してください。（表現方法：教科書のような違和感のない優しい丁寧なインドネシア語表現)'
      : 'インドネシア語の例文「$text」を日本語に翻訳してください。（文体：ですます調、表現方法：教科書のような違和感のない優しい丁寧な日本語表現';

    final queryParams = {
      'key': dotenv.env['GEMINI_API_KEY'],
    };
    final body =
    {
      'contents': [
        {'role': 'user', 'parts': { 'text': prompt }},
      ],
    };

    final response = await _api.post('/gemini-pro:generateContent', json.encode(body) , query: queryParams,);

    response.when(
        success: (success) {
          dev.log(success.toString());
        },
        error: (error) {
          return APIResponse.error(error);
        },);

    if (response is APISuccess) {
      final value = response.value as Map<String, dynamic>;
      try {
        final result = TranslateResponse(
          code: 200,
          text: value['candidates'][0]['content']['parts'][0]['text'] as String,
        );

        return result;
      } catch (e) {
        throw Exception(e);
      }
    } else if (response is APIError) {
      throw Exception(response.exception);
    } else {
      throw Exception('timeout');
    }
  }

  Future<TranslateResponse> getDetailExplanation({
    required String text,
    required bool isSourceJapanese,
  }) async {
    final prompt =
    'インドネシア語の例文「$text」の意味と文法を日本語で解説してください。（文体：ですます調、表現方法：教科書のような違和感のない優しい丁寧な日本語表現, テキスト形式: マークダウン形式)';

    final queryParams = {
      'key': dotenv.env['GEMINI_API_KEY'],
    };
    final body =
    {
      'contents': [
        {'role': 'user', 'parts': { 'text': prompt }},
      ],
    };

    final response = await _api.post('/gemini-pro:generateContent', json.encode(body) , query: queryParams,);

    response.when(
      success: (success) {
        dev.log(success.toString());
      },
      error: (error) {
        return APIResponse.error(error);
      },);

    if (response is APISuccess) {
      final value = response.value as Map<String, dynamic>;
      try {
        final result = TranslateResponse(
            code: 200,
            text: value['candidates'][0]['content']['parts'][0]['text'] as String,
        );

        return result;
      } catch (e) {
        throw Exception(e);
      }
    } else if (response is APIError) {
      throw Exception(response.exception);
    } else {
      throw Exception('timeout');
    }
  }

  Future<TangoEntity?> searchWord(String value) async {
    TangoEntity? searchedWord;
    final regExpForSpaceAndNewlines = RegExp(r'[\s\n]');
    final wordList = value.split(regExpForSpaceAndNewlines);
    final regExpOfNyaMuKu = RegExp(r'(nya|ku|mu)$');
    const baseSearchLength = 3;
    for (var i = 0; i < wordList.length; i++) {
      final remainCount = [baseSearchLength, wordList.length - i].reduce(min);
      var searchText = '';
      for (var j = 0; j < remainCount; j++) {
        if (j>0) {
          searchText = '$searchText ';
        }
        searchText = searchText + wordList[i + j];
        if (j == 0) {
          if (searchText.contains(regExpOfNyaMuKu)) {
            final replacedSearchText =
            searchText.replaceAll(regExpOfNyaMuKu, '');
            if (searchedWord != null) {
              continue;
            }
            final searchResult = await search(replacedSearchText);
            if (searchResult.isNotEmpty) {
              searchedWord = searchResult.first;
            }
          }
        }
        if (searchedWord != null) {
          continue;
        }
        final searchResult = await search(searchText);
        if (searchResult.isNotEmpty) {
          searchedWord = searchResult.first;
        }
      }
    }
    if (searchedWord == null) {
      final searchResultInUnregisteredWords =
        await searchInUnregisteredWord(value);
      if (searchResultInUnregisteredWords.isEmpty) {
        unawaited(registerUnregisteredWord(value));
      } else {
        return searchResultInUnregisteredWords.first.toTangoEntity();
      }
    }
    return searchedWord;
  }

  Future<void> registerUnregisteredWord(String unregisteredIndonesian) async {
    final searchText = unregisteredIndonesian.toLowerCase()
        .replaceAll('.', '')
        .replaceAll(',', '')
        .replaceAll('\n', '');
    final unregisteredTangoEntity = await getUnregisteredWordData(text: searchText);
    try {
      await Supabase.instance.client.from('unregistered_words').insert(unregisteredTangoEntity.toJson(), defaultToNull: true);
    } catch (e) {
      dev.log(e.toString());
    }
  }

  Future<UnregisteredTangoEntity> getUnregisteredWordData({
    required String text,
  }) async {
    final prompt =
    '''
    インドネシア語の「$text」について以下のデータを指定するjson形式で出力してください。
    もし「$text」が存在しない場合は、空のjsonを出力してください。
    
    - 該当する日本語(複数ある場合は","つなぎで出力)
    - 該当する英語(複数ある場合は","つなぎで出力)
    - 「$text」を使用したインドネシア語の例文(126字以内)
    - 上記のインドネシア語の例文の日本語訳
    - 「$text」に関連した同義語(同義語: XXX, XXXの形式)や反意語((反意語: XXX, XXXの形式))、その他関連語(複数ある場合は","つなぎで出力)
    - 「$text」の品詞
    
    出力json形式
    ```
    {
      "indonesian": "terdiam",
      "japanese": 該当する日本語,
      "english": 該当する英語,
      "example": 「$text」を使用したインドネシア語の例文,
      "example_jp": 上記のインドネシア語の例文の日本語訳,
      "description": 「$text」に関連した同義語や反意語、その他関連語
      "part_of_speech": 「$text」の品詞
    }
    ```
    '''
    ;

    final queryParams = {
      'key': dotenv.env['GEMINI_API_KEY'],
    };
    final body =
    {
      'contents': [
        {'role': 'user', 'parts': { 'text': prompt }},
      ],
    };

    final response = await _api.post('/gemini-pro:generateContent', json.encode(body) , query: queryParams,);

    response.when(
      success: (success) {
        dev.log(success.toString());
      },
      error: (error) {
        return APIResponse.error(error);
      },);

    if (response is APISuccess) {
      final value = response.value as Map<String, dynamic>;
      try {
        final response = value['candidates'][0]['content']['parts'][0]['text'] as String;
        final convertedMap = convertToJsonMap(response);
        final unregisteredTangoEntity =
          UnregisteredTangoEntity.fromJson(convertedMap);

        return unregisteredTangoEntity;
      } catch (e) {
        throw Exception(e);
      }
    } else if (response is APIError) {
      throw Exception(response.exception);
    } else {
      throw Exception('timeout');
    }
  }

  Future<List<TangoEntity>> searchRelatedWords(TangoEntity entity) async {
    final relatedWords = <TangoEntity>[];
    if (entity.description == null || entity.description!.isEmpty) {
      return relatedWords;
    }
    final regExpForSpaceAndNewlines = RegExp(r'[\s\n]');
    final wordList = extractIndonesianWords(entity.description!);
    final regExpOfNyaMuKu = RegExp(r'(nya|ku|mu)$');
    for (var i = 0; i < wordList.length; i++) {
      final searchText = wordList[i];
      if (searchText.contains(regExpOfNyaMuKu)) {
        final replacedSearchText =
        searchText.replaceAll(regExpOfNyaMuKu, '');
        if (relatedWords
            .firstWhereOrNull((e) => e.indonesian == replacedSearchText) != null) {
          continue;
        }
        relatedWords.addAll(
          await search(replacedSearchText),);
      }
      if (relatedWords
          .firstWhereOrNull((e) => e.indonesian == searchText) != null) {
        continue;
      }
      relatedWords.addAll(await search(searchText));
    }
    return relatedWords;
  }

  List<String> extractIndonesianWords(String text) {
    final indonesianWordPattern = RegExp(r'\b[a-zA-Z]+\b');
    final matches = indonesianWordPattern.allMatches(text);
    final indonesianWords = matches.map((match) => match.group(0)!).toList();
    return indonesianWords;
  }

  Future<List<TangoEntity>> searchIncludeWords(String value) async {
    final includedWords = <TangoEntity>[];
    final regExpForSpaceAndNewlines = RegExp(r'[\s\n]');
    final wordList = value.split(regExpForSpaceAndNewlines);
    final regExpOfNyaMuKu = RegExp(r'(nya|ku|mu)$');
    const baseSearchLength = 3;
    for (var i = 0; i < wordList.length; i++) {
      final remainCount = [baseSearchLength, wordList.length - i].reduce(min);
      var searchText = '';
      for (var j = 0; j < remainCount; j++) {
        if (j>0) {
          searchText = '$searchText ';
        }
        searchText = searchText + wordList[i + j];
        if (j == 0) {
          if (searchText.contains(regExpOfNyaMuKu)) {
            final replacedSearchText =
              searchText.replaceAll(regExpOfNyaMuKu, '');
            if (includedWords
                .firstWhereOrNull((e) => e.indonesian == replacedSearchText) != null) {
              continue;
            }
            includedWords.addAll(
                await search(replacedSearchText),);
          }
        }
        if (includedWords
            .firstWhereOrNull((e) => e.indonesian == searchText) != null) {
          continue;
        }
        includedWords.addAll(await search(searchText));
      }
    }
    return includedWords;
  }

  Future<List<TangoEntity>> search(String search) async {
    final searchText = search.toLowerCase()
        .replaceAll('.', '')
        .replaceAll(',', '')
        .replaceAll('\n', '');
    final searchWordJsonList = await Supabase.instance.client
        .from('words')
        .select()
        .eq('indonesian', searchText);
    final searchWordList =
      searchWordJsonList.map(TangoEntity.fromJson).toList();
    return searchWordList;
  }

  Future<List<UnregisteredTangoEntity>> searchInUnregisteredWord(String search) async {
    final searchText = search.toLowerCase()
        .replaceAll('.', '')
        .replaceAll(',', '')
        .replaceAll('\n', '');
    final searchWordJsonList = await Supabase.instance.client
        .from('unregistered_words')
        .select()
        .eq('indonesian', searchText);
    final searchWordList =
    searchWordJsonList.map(UnregisteredTangoEntity.fromJson).toList();
    return searchWordList;
  }

  Map<String, dynamic> convertToJsonMap(String jsonString) {
    jsonString = jsonString
        .replaceAll("'", '"')
        .replaceAll('`', '')
        .replaceAll('json', '')
        .replaceAll('\n', '');
    return jsonDecode(jsonString) as Map<String, dynamic>;
  }
}
