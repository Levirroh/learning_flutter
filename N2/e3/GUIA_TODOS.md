# Guia dos TODOs

## TODO 01 - filtro
Usar texto, categoria e inscricao para produzir a lista exibida.

## TODO 02 - detalhes
Abrir `DetalhesEventoScreen` com `Navigator.push`, receber `bool` e reagir ao retorno.

## TODO 03 - novo evento
Abrir `NovoEventoScreen`, receber `Evento`, inserir na lista e mostrar `SnackBar`.

## TODO 04 - sair
Confirmar com `AlertDialog` e limpar a pilha com `pushAndRemoveUntil`.

## TODO 05 - map()
Transformar `categorias` em `FilterChip` usando `map()` e `toList()`.

## TODO 06 - estado local
Alternar `evento.inscrito` usando `setState()`.

## TODO 07 - excluir
Confirmar a exclusao e retornar `true` para a Home.

## TODO 08 - detalhes
Alternar a inscricao na tela de detalhes e atualizar o texto do botao.

## TODO 09 - formulario
Validar, mostrar carregamento, construir `Evento` e devolver o objeto.

## TODO 10 - Map<K,V>
Retornar duas configuracoes em um `Map<String, bool>`.

## TODO 11 - ciclo de vida
Criar `AppLifecycleListener` e registrar mudancas de `AppLifecycleState`.

## TODO 12 - dispose
Liberar o listener em `dispose()`.

## Conferência da versão concluída

Os 12 pontos foram implementados nos arquivos originais de lib/screens/. A análise não encontrou problemas e os nove testes automatizados passaram.

Os testes cobrem entrada, combinação de filtros, inscrição e retorno dos detalhes, confirmação de exclusão, validação e retorno do cadastro, inserção na Home, Map de configurações, saída com limpeza da pilha e liberação do listener. A execução real no emulador Android foi concluída em 27/10/2026. Os registros dessa conferência acompanham a entrega separadamente desta pasta de código.
