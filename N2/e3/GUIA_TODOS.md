# Conferência da atividade

Todos os caminhos abaixo são relativos à pasta do projeto. As marcações no código identificam implementações concluídas, não trechos pendentes.

| Item | Arquivo | Implementação e teste sugerido |
| --- | --- | --- |
| 01 | lib/screens/home_screen.dart | `_eventosFiltrados` combina título/local, categoria e inscrição com `where().toList()`. Pesquisar por LABORATÓRIO e escolher Oficina deve mostrar Git na prática. |
| 02 | lib/screens/home_screen.dart | `_abrirDetalhes` usa `push<bool>`, envia o Evento e remove apenas quando o retorno é true. Ao voltar sem excluir, atualiza a lista. |
| 03 | lib/screens/home_screen.dart | `_novoEvento` usa `push<Evento>`, adiciona o resultado com setState e mostra SnackBar. Voltar sem salvar não adiciona nada. |
| 04 | lib/screens/home_screen.dart | `_sair` confirma em diálogo e usa pushAndRemoveUntil com predicado false. Cancelar mantém a Home. |
| 05 | lib/screens/home_screen.dart | As categorias viram FilterChip com map().toList(), seleção e setState. |
| 06 | lib/screens/home_screen.dart | Callback do EventoCard alterna inscrito com setState. Cancelar sob o filtro de inscritos retira o evento imediatamente. |
| 07 | lib/screens/detalhes_evento_screen.dart | Cancelar fecha apenas o diálogo. Confirmar fecha os detalhes com Navigator.pop(context, true). |
| 08 | lib/screens/detalhes_evento_screen.dart | Botão alterna inscrição com setState e muda o texto. A Home recebe a alteração no mesmo objeto. |
| 09 | lib/screens/novo_evento_screen.dart | Form valida os três campos de texto. O carregamento dura 600 ms, os valores criam um Evento e pop devolve esse objeto. |
| 10 | lib/screens/configuracoes_screen.dart | Retorna Map<String, bool> com exatamente notificacoes e modoCompacto. A Home aplica os valores. |
| 11 | lib/screens/ciclo_vida_screen.dart | Cria AppLifecycleListener em initState. onStateChange atualiza estado, histórico e interface e usa debugPrint. |
| 12 | lib/screens/ciclo_vida_screen.dart | dispose libera o listener antes de super.dispose(). |

## Evidências que ainda precisam ser produzidas pelo estudante

- Identificação completa.
- Captura da lista com filtros aplicados.
- Captura dos detalhes.
- Captura do cadastro.
- Execução real de Home/retorno no Android e captura do histórico.
- Explicações próprias, incluindo a diferença entre navegar nas rotas Flutter e colocar o app em segundo plano.
- Exportação e conferência do PDF final.

Os testes de widgets verificam os fluxos automaticamente. A simulação de estados usada nesses testes não substitui o teste no dispositivo ou emulador.
