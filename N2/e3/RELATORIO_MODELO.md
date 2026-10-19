# Agenda de Eventos

Estudante: [nome completo]

Matrícula: [preencher]

Disciplina: [preencher]

Professor(a): [preencher]

Turma e data: [preencher]

## 1. Apresentação

[Apresente o aplicativo e seu objetivo: consultar eventos acadêmicos, filtrar resultados e administrar inscrições.]

## 2. O que foi implementado

[Explique com suas palavras as telas e a organização em models, data, widgets e screens. Cite o uso de setState para atualizar a interface. O arquivo GUIA_TODOS.md relaciona os 12 itens às funções implementadas.]

## 3. Lista, pesquisa e inscrições

**Captura 1 — Lista com filtros aplicados**

[Insira uma captura legível com busca, categoria selecionada e resultados.]

[Descreva os filtros usados e o motivo de os eventos mostrados atenderem aos critérios. Explique que a busca considera título OU local, combinada com categoria E inscrição.]

[Explique o uso de map().toList() para gerar os FilterChip e a atualização imediata da inscrição com setState.]

## 4. Detalhes e navegação

**Captura 2 — Detalhes de um evento**

[Insira uma captura com os dados de um evento e os botões.]

[Explique como Navigator.push e MaterialPageRoute enviam o objeto Evento, como a inscrição altera o mesmo objeto e como pop retorna true na exclusão. Conte o resultado dos testes de cancelar e confirmar a exclusão.]

[Explique que a saída confirmada usa pushAndRemoveUntil para remover as rotas anteriores e retornar à entrada.]

## 5. Cadastro de evento

**Captura 3 — Cadastro preenchido**

[Insira uma captura do formulário preenchido. Se possível, acrescente uma imagem da validação ou do carregamento.]

[Descreva os campos, a validação, a espera de 600 ms com indicador e o retorno de um Evento por Navigator.pop. Explique como a Home adiciona esse objeto à lista.]

## 6. Configurações e Map

[Explique o retorno de um Map<String, bool> com as chaves notificacoes e modoCompacto. Descreva o resultado de salvar e de voltar sem salvar. A preferência de notificações é local; o modo compacto oculta as descrições dos cards.]

## 7. Ciclo de vida no Android

Dispositivo ou emulador: [preencher]

Versão do Android: [preencher]

Data do teste: [preencher]

1. [Informe o estado inicial realmente mostrado ao abrir a tela Ciclo de vida.]
2. [Descreva o que fez ao pressionar Home e quanto tempo aguardou.]
3. [Descreva como retornou ao aplicativo.]
4. [Transcreva, na ordem, os estados recebidos na interface e observados no console.]

**Captura 4 — Ciclo de vida após Home e retorno**

[Insira uma captura legível do estado atual e do histórico após o teste real.]

[Explique como AppLifecycleListener é criado no initState e liberado no dispose. Descreva o uso de onStateChange, setState e debugPrint.]

[Compare navegação e segundo plano. Navigator.push normalmente mantém o State da rota anterior montado. Trocar de rota Flutter não significa criar outra Activity Android nem colocar o app em paused. Relacione a explicação aos estados realmente observados.]

Não use os estados simulados nos testes automatizados como resultado da execução no Android.

## 8. Conferência dos testes

| Verificação | Resultado observado |
| --- | --- |
| Entrada com nome vazio e válido | [preencher] |
| Busca por título e por local | [preencher] |
| Combinação dos três filtros | [preencher] |
| Inscrever/cancelar na lista e nos detalhes | [preencher] |
| Cancelar e confirmar exclusão | [preencher] |
| Cadastro inválido e válido | [preencher] |
| Salvar configurações e voltar sem salvar | [preencher] |
| Cancelar e confirmar saída | [preencher] |
| Home/retorno no Android | [preencher] |

## 9. Considerações finais

[Conte brevemente o que aprendeu e alguma dificuldade encontrada.]

Antes de entregar: substitua os campos entre colchetes, complete a identificação no README, confira as capturas, exporte em PDF e verifique a legibilidade. Atualize o ZIP caso altere o código ou o README.
