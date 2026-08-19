# learning_flutter
initial flutter repo, based on college provided content. 


# Ideia mini jogos
1. Jogo de 2 para competir quantos clica mais em cada lado da tela. (simples)
2. Jogo estilo pou de andar de carrinho e tentar não tombar. (médio/pode ser complexo)
3. Campo minado (médio).
4. Jogo de reação (simples) (troca a cor de fundo e tem que clicar o mais rápido possível).
5. Jogo de brick breaker (médio/pode ser complexo).
6. Jogo de balão indo pra cima estilo "Rise Up" (ballon game).
7. 

# Ideia app autoral

## App de gravação em loop personalizado de áudio.

 Aplicativo simples com uma interface direta.
 - Possibilidade de gravar diferentes faixas de áudio e a possibilidade de tocar elas em loop (todas ou somente selecionadas).


# Setting Up:

1. SDK Flutter: https://docs.flutter.dev/install/quick?_gl=1%2Awcutxw%2A_ga%2AMTY3MDg5Nzg2My4xNzg1ODkwNDY5%2A_ga_04YGWK0175%2AczE3ODcwOTYwODEkbzMkZzEkdDE3ODcwOTYwOTIkajQ5JGwwJGgw
- Baixar no OS que desejar (manual) e selecionar o SDK (zip).
2. Extrair arquivos baixados (recomendado extrair diretamente no disco C, tire vínculo com o OneDrive).
3. Na pasta extraida, procure por "bin".
    1. Adicionar esta pasta às variáveis de ambiente (ex: "C:\flutter_windows_3.32.8-stable\flutter\bin" - Essa versão pode estar desatualizada)
    2. Em path, clique em editar, clique em novo, e adicione o caminho.
4. Baixar Android Studio (para os SDK's) ("https://developer.android.com/studio?hl=pt-br")
    1. Abrir o app instalado para instalar as dependências.
    2. No app, selecione o "More Options", selecione o SDK Manager
        1. Em SDK Plataforms, terá algum já baixado, provavelmente o 16
        2. No SDK Tools:
            1. Android SDK Build TOols
            2. NDK (Side by Side)
            3. Android SDK Command-line Tools (latest)
            4. CMake
            5. Android Emulator
            6. Android Emulator Hypervisor Driver (installer)
            7. Android SDK Platform-Tools
5. Verificar a instalação do Flutter:
    1. Abra o powershell e rode:
        1. flutter doctor: Retorno positivo é verde
            1. Em caso de contrato, rode: "flutter doctor --android-licenses"
                1. Aceite tudo e venda sua alma.
            2. Em caso de C# 
                1. Abra o Visual Studio
                2. Modifique a versão 2022
                3. Selecione o pacote
                    1. Desktop com C++
                    2. Mobile com C++
            3. Erro de git/permissão do git.
                1. "git config --global --add safe.directory C:[caminho da pasta do flutter]
6. No VS Code, baixe o pacote "Flutter" 
7. Para um projeto novo:
    1. Abra o command Pallet (em View)
    2. Selecione criar um novo projeto Flutter.
    3. Na parte inferior direita, é possível selecionar a plataforma alvo da aplicação (deve estar em Windows (windows-64x))
        1. O offline é o emulador normal, lembra a compilação do projeto (mantém o carregado pela última vez)
        2. Caso queira resetar, use o "cold boot".
    4. Para rodar um código, use "flutter run"
