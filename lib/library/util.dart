import 'package:intl/intl.dart';

class Util {
  /// Capitaliza somente a primeira letra da primeira palavra do texto.
  /// Exemplo: flutter framework, terá o retorno Flutter framework
  static String capitalizarSentenca(String text){
    if (text == null || text.trim().isEmpty) return '';

    if (text.trim().length == 1){
      return text.toLowerCase();
    }

    text = text.toLowerCase().trim();

    var rest = text.substring(1);
    var init = text.substring(0, 1).toString().toUpperCase();

    return '$init$rest'.trim();
  }

  /// Capitaliza todos os caracteres do texto.
  /// Exemplo: flutter framework, terá o retorno FLUTTER FRAMEWORK
  static String capitalizarCaractere(String text){
    if (text == null || text.trim().isEmpty) return '';
    return text.toUpperCase().trim();
  }

  /// Capitaliza a primeira letra de cada palavra do texto.
  /// Exemplo: flutter framework, terá o retorno Flutter Framework
  static String capitalizarPalavra(String text){
    if (text == null || text.trim().isEmpty) return '';

    if (text.trim().length == 1){
      return text.toLowerCase();
    }

    var retorno = '';
    text = text.toLowerCase().trim().trimLeft();
    text = text.replaceAll('  ', ' ');

    var arrayAux = text.split(' ');
    for (String value in arrayAux){
      var rest = value.substring(1);
      var init = value.substring(0, 1).toString().toUpperCase();

      retorno += '$init$rest ';
    }
    return retorno.trim();
  }

  /// Retorna a primeira palavra do texto.
  /// Exemplo: flutter framework, terá o retorno Flutter framework
  static String primeiraPalavra(String text){
    if (text == null || text.trim().isEmpty) return '';

    return capitalizarSentenca(text.split(' ').first);
  }

  /// Retira caracteres especiais de um texto.
  /// Exemplo: flutter-framework, terá o retorno flutterframework
  static String retirarCaracteresEspeciais(String text){
    if (text.trim().isEmpty) return '';

    return text.replaceAll(new RegExp(r'[^\w\s]+'),'').trim();
  }

  static String mascararCnpjCpf(String cnpjCpf){
    if (cnpjCpf == null) return '';

    if (cnpjCpf.length >= 14){
      return mascararCNPJ(cnpjCpf);
    } else if (cnpjCpf.length >= 11){
      return mascararCPF(cnpjCpf);
    }

    return cnpjCpf;
  }

  static String mascararCNPJ(String cnpj){
    if (cnpj == null) return '';

    cnpj = retirarCaracteresEspeciais(cnpj);

    if (cnpj.isEmpty || cnpj.length != 14) return cnpj;

    final bloco1 = cnpj.substring(0,2);
    final bloco2 = cnpj.substring(2,5);
    final bloco3 = cnpj.substring(5,8);
    final bloco4 = cnpj.substring(8,12);
    final bloco5 = cnpj.substring(12,14);

    cnpj = '$bloco1.$bloco2.$bloco3/$bloco4-$bloco5';

    return cnpj;
  }

  static String mascararCPF(String cpf){
    if (cpf == null) return '';

    cpf = retirarCaracteresEspeciais(cpf);

    if (cpf.isEmpty || cpf.length != 11) return cpf;

    final bloco1 = cpf.substring(0,3);
    final bloco2 = cpf.substring(3,6);
    final bloco3 = cpf.substring(6,9);
    final bloco4 = cpf.substring(9,11);

    cpf = '$bloco1.$bloco2.$bloco3-$bloco4';

    return cpf;
  }

  static String mascararTelefoneCelular(String numero){
    if (numero == null || numero.isEmpty || retirarCaracteresEspeciais(numero).length < 8 || retirarCaracteresEspeciais(numero).length > 11){
      return numero;
    }

    numero = retirarCaracteresEspeciais(numero);
    numero = numero.replaceAll(' ', ''); // retirar os espaços
    int indexPosicaoZero = numero.indexOf('0');
    if (indexPosicaoZero == 0){ // se estiver na primeira posição retirar pra gerar mascara sem prefixo nacional
      numero = numero.substring(1,numero.length);
    }

    // telefone sem ddd
    if (numero.length == 8){
      final bloco1 = numero.substring(0,4);
      final bloco2 = numero.substring(4,8);
      numero = '$bloco1-$bloco2';
    }

    // telefone com ddd
    if (numero.length == 10){
      final bloco1 = numero.substring(0,2);
      final bloco2 = numero.substring(2,6);
      final bloco3 = numero.substring(6,10);
      numero = '($bloco1)$bloco2-$bloco3';
    }

    // celular sem ddd
    if (numero.length == 9){
      final bloco1 = numero.substring(0,5);
      final bloco2 = numero.substring(5,9);
      numero = '$bloco1-$bloco2';
    }

    // celular com ddd
    if (numero.length == 11){
      final bloco1 = numero.substring(0,2);
      final bloco2 = numero.substring(2,7);
      final bloco3 = numero.substring(7,11);
      numero = '($bloco1)$bloco2-$bloco3';
    }

    return numero;
  }

  static String mascararCEP(String cep){
    if (cep == null) return '';

    cep = retirarCaracteresEspeciais(cep);

    if (cep.isEmpty || cep.length != 8) return cep;

    final bloco1 = cep.substring(0,5);
    final bloco2 = cep.substring(5,8);

    cep = '$bloco1-$bloco2';

    return cep;
  }

  /// Retorna uma String sem acentuação
  /// Exemplo: Programação, retornará Programacao
  static String removerAcento(String palavra) {

    //var response = word;

    final letraAcentuada = ['ã', 'â', 'à', 'á', 'Ã', 'Â', 'À', 'Á', 'ê', 'è', 'é', 'Ê',
      'È', 'É', 'î', 'ì', 'í', 'Î', 'Ì', 'Í', 'õ', 'ô', 'ò', 'ó', 'Õ', 'Ô', 'Ò', 'Ó',
      'û', 'ù', 'ú', 'Û', 'Ù', 'Ú', 'ç', 'Ç'];

    Map<String, String> mapaAcento = {'ã': 'a', 'â': 'a', 'à': 'a', 'á': 'a',
      'Ã': 'A', 'Â': 'A', 'À': 'A', 'Á': 'A', 'ê': 'e', 'è': 'e', 'é': 'e',
      'Ê': 'E', 'È': 'E', 'É': 'E', 'î': 'i', 'ì': 'i', 'í': 'i', 'Î': 'I', 'Ì': 'I', 'Í': 'I',
      'õ': 'o', 'ô': 'o', 'ò': 'o', 'ó': 'o', 'Õ': 'O', 'Ô': 'O', 'Ò': 'O', 'Ó': 'O',
      'û': 'u', 'ù': 'u', 'ú': 'u', 'Û': 'U', 'Ù': 'U', 'Ú': 'U', 'ç': 'C', 'Ç': 'C'};

    /*for (final letra in letraAcentuada){
      var semAcento = mapaAcento[letra];
      response = response.replaceAll(letra, semAcento);
    }*/

    letraAcentuada.forEach((letra){
      final semAcento = mapaAcento[letra];
      palavra = palavra.replaceAll(letra, semAcento);
    });

    return palavra;
  }

  bool isEmail(String pEmail) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(pEmail);
  }

  static String formatDouble(double value){
    final formatter = NumberFormat('#,##0.00', 'pt_BR');
    try{
      return formatter.format(value);
    } catch (e) {
      print(e);
    }
    return '0';
  }

  static String formatInteger(num value){
    final formatter = NumberFormat('#,##0', 'pt_BR');
    try{
      return formatter.format(value);
    } catch (e) {
      print(e);
    }
    return '0';
  }

  static String formatCurrency(double value){
    final formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');
    try{
      return formatter.format(value);
    } catch (e) {
      print(e);
    }
    return '0';
  }

  /// Função util para printar textos longos
  static void printWrapped(Object text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches('$text').forEach((match) => print(match.group(0)));
  }
}
