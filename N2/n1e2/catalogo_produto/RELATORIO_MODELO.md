# Catálogo de Jogos

Disciplina: [preencher]

Professor(a): [preencher]

Integrantes: [nomes completos e matrículas]

Turma: [preencher]

Data: [preencher]

## 1. Objetivo

[Escreva com suas palavras o objetivo da atividade e apresente o tema escolhido: jogos de tabuleiro.]

## 2. Catálogo e classe Produto

[Explique como a classe Produto, em lib/classes/catalog_item.dart, reúne os dados de cada jogo: name, description, price, quantity e color. Explique por que usar uma lista de objetos facilita montar o catálogo.]

**Captura 1 — Catálogo com War, Monopoly e Jogo da Vida**

[Inserir captura legível dos três cards com nomes, preços e indicadores de quantidade.]

[Explique o que a imagem mostra e como o Stack em lib/assets/item_card.dart posiciona o indicador sobre o ícone de dado.]

## 3. Navegação e envio do produto

[Explique como o botão do card usa Navigator.push() e MaterialPageRoute para abrir ItemScreen(item: item, history: widget.history). Descreva como a tela usa o objeto recebido e como o botão de retorno chama Navigator.pop().]

**Captura 2 — Detalhes do primeiro jogo: [nome]**

[Inserir captura com nome, descrição, preço e quantidade.]

[Explique quais dados correspondem ao jogo selecionado.]

**Captura 3 — Detalhes do segundo jogo: [nome]**

[Inserir captura com os dados de um jogo diferente.]

[Compare os dados e explique como isso demonstra o envio do produto correto.]

## 4. Transformações com map() e toList()

[Explique: map() transforma cada elemento e toList() materializa o resultado em uma lista. Localize os usos em lib/main_screen.dart: produtos em cards, números em strings, números multiplicados por 2, palavras em Text e nomes em botões. Há também usos na apresentação do histórico e na formatação da lista de strings.]

**Captura 4 — Transformações numéricas**

[Inserir captura com a lista original e os dois resultados.]

[Explique a diferença entre a List<String> strings, gerada por number.toString(), e a lista de inteiros doubled. As aspas exibidas na interface ajudam a distinguir os resultados.]

**Captura 5 — Palavras e botões**

[Inserir captura com as palavras Flutter, é, incrível e os três botões de nomes.]

[Explique a criação dos widgets a partir de listas e o uso de Wrap para permitir quebra de linha.]

**Captura 6 — Mensagem após pressionar [nome]**

[Inserir captura enquanto o SnackBar estiver visível.]

[Explique como o botão identifica o nome correspondente.]

## 5. Ciclo de vida e testes no Android

Dispositivo ou emulador: [preencher]

Versão do Android: [preencher]

Data do teste: [preencher]

[Explique o uso de WidgetsBindingObserver em lib/main.dart. O estado inicial é consultado em WidgetsBinding.instance.lifecycleState e os eventos seguintes são recebidos em didChangeAppLifecycleState. O histórico tem horário e ordem de recebimento. A mesma lista observável é enviada para as duas telas.]

| Ação executada | Estados realmente observados, na ordem | Observação |
| --- | --- | --- |
| Abrir o aplicativo | [preencher] | [preencher] |
| Abrir War e retornar | [preencher ou informar que não houve novos eventos] | [preencher] |
| Abrir Monopoly e retornar | [preencher] | [preencher] |
| Abrir Jogo da Vida e retornar | [preencher] | [preencher] |
| Pressionar Home | [preencher após retornar] | [preencher] |
| Retornar ao aplicativo | [preencher] | [preencher] |

**Captura 7 — Histórico após navegação entre telas**

[Inserir captura e descrever o resultado real.]

**Captura 8 — Histórico após Home e retorno**

[Inserir captura legível com a sequência observada. Se necessário, usar mais de uma imagem.]

[Compare os dois testes. push() e pop() alteram as rotas dentro do aplicativo; abrir detalhes não significa enviar o aplicativo ao segundo plano. O estado paused é relacionado ao ciclo de vida do app, não à existência de uma tela anterior na pilha. Relacione essa explicação ao resultado observado.]

Preencha esta seção com a execução no Android. Não copie estados esperados como se tivessem ocorrido. Eventos simulados nos testes automatizados não são evidências desse teste.

## 6. Considerações finais

[Em um parágrafo, conte o que foi aprendido e alguma dificuldade encontrada na implementação ou nos testes.]

## Conferência antes de exportar

- Substituir todos os campos entre colchetes por informações e explicações próprias.
- Conferir a navegação de todos os três produtos.
- Conferir se as imagens correspondem ao código entregue e estão legíveis.
- Completar os integrantes no README e no relatório.
- Exportar para PDF e abrir o arquivo para verificar as páginas.
- Entregar o ZIP do projeto e o PDF do relatório.
