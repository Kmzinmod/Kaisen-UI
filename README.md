loadstring(game:HttpGet("https://raw.githubusercontent.com/Kmzinmod/Kaisen-UI/refs/heads/main/UI.luau"))()





═══════════════════════════════════════════════════════════
              KAISEN UI - MANUAL FÁCIL
                 Guia Passo a Passo
═══════════════════════════════════════════════════════════

📌 O QUE É ISSO?
───────────────────────────────────────────────────────────
É uma interface (UI) que você pode colocar em seus scripts
do Roblox. Ela aparece como uma janela com botões, opções
e configurações que você pode usar nos seus jogos.


═══════════════════════════════════════════════════════════
1️⃣ COMO COLOCAR A UI NO SEU SCRIPT
───────────────────────────────────────────────────────────

Copie e cole isso no seu script:

local KaisenUI = loadstring(game:HttpGet("URL_AQUI"))({
    Title = "Meu Script",
    ToggleKey = Enum.KeyCode.G
})

Pronto! A UI já vai funcionar. Troque "URL_AQUI" pelo link
onde você guardou o script da UI.

═══════════════════════════════════════════════════════════
2️⃣ COMO PERSONALIZAR A UI
───────────────────────────────────────────────────────────

Você pode mudar as cores, tamanho e texto. Veja:

EXEMPLO 1 - UI AZUL (PADRÃO):
────────────────────────────
local KaisenUI = loadstring(game:HttpGet("URL"))({
    Title = "Meu Script",
    ToggleKey = Enum.KeyCode.G
})

EXEMPLO 2 - UI VERMELHA:
────────────────────────
local KaisenUI = loadstring(game:HttpGet("URL"))({
    Title = "🔥 Meu Script",
    ToggleKey = Enum.KeyCode.G,
    MainColor = Color3.fromRGB(255, 0, 0)  -- VERMELHO
})

EXEMPLO 3 - UI ROXA:
────────────────────
local KaisenUI = loadstring(game:HttpGet("URL"))({
    Title = "💜 Meu Script",
    ToggleKey = Enum.KeyCode.G,
    MainColor = Color3.fromRGB(150, 0, 255)  -- ROXO
})

═══════════════════════════════════════════════════════════
3️⃣ CORES QUE VOCÊ PODE USAR
───────────────────────────────────────────────────────────

Para mudar a cor principal (MainColor), use:

Color3.fromRGB(100, 180, 255)  → AZUL (PADRÃO)
Color3.fromRGB(255, 0, 0)      → VERMELHO
Color3.fromRGB(0, 255, 0)      → VERDE
Color3.fromRGB(255, 255, 0)    → AMARELO
Color3.fromRGB(150, 0, 255)    → ROXO
Color3.fromRGB(255, 100, 0)    → LARANJA
Color3.fromRGB(255, 0, 255)    → ROSA
Color3.fromRGB(0, 255, 255)    → CIANO

═══════════════════════════════════════════════════════════
4️⃣ TE CLAS PARA ABRIR A UI
───────────────────────────────────────────────────────────

Troque Enum.KeyCode.G por outra tecla:

Enum.KeyCode.G     → TECLA G
Enum.KeyCode.F     → TECLA F
Enum.KeyCode.R     → TECLA R
Enum.KeyCode.Q     → TECLA Q
Enum.KeyCode.E     → TECLA E
Enum.KeyCode.Z     → TECLA Z
Enum.KeyCode.X     → TECLA X
Enum.KeyCode.C     → TECLA C
Enum.KeyCode.V     → TECLA V

EXEMPLO - USAR TECLA F:
───────────────────────
local KaisenUI = loadstring(game:HttpGet("URL"))({
    Title = "Meu Script",
    ToggleKey = Enum.KeyCode.F  -- AGORA É F
})

═══════════════════════════════════════════════════════════
5️⃣ COMO CRIAR SEÇÕES
───────────────────────────────────────────────────────────

Seções são como abas na lateral esquerda.

SINTAXE:
KaisenUI:AddSection("NOME", "ÍCONE", function(section)
    -- Coloque os elementos aqui
end)

EXEMPLO:
KaisenUI:AddSection("Principal", "🏠", function(section)
    -- Aqui você coloca botões e opções
end)

KaisenUI:AddSection("Configurações", "⚙️", function(section)
    -- Aqui você coloca mais opções
end)

═══════════════════════════════════════════════════════════
6️⃣ ELEMENTOS QUE VOCÊ PODE ADICIONAR
───────────────────────────────────────────────────────────

6.1 - TOGGLE (INTERRUPTOR LIGA/DESLIGA)
────────────────────────────────────────
Cria um botão que liga e desliga.

SINTAXE:
KaisenUI:AddToggle("NOME", section, function(ativado)
    -- Código quando liga/desliga
end)

EXEMPLO:
KaisenUI:AddToggle("Auto Farm", section, function(ativado)
    if ativado then
        print("Auto Farm LIGADO")
    else
        print("Auto Farm DESLIGADO")
    end
end)

6.2 - BUTTON (BOTÃO NORMAL)
───────────────────────────
Cria um botão que você clica uma vez.

SINTAXE:
KaisenUI:AddButton("NOME", section, function()
    -- Código quando clicar
end)

EXEMPLO:
KaisenUI:AddButton("Teleportar", section, function()
    print("Teleportando...")
    -- Coloque seu código aqui
end)

6.3 - SLIDER (CONTROLE DESLIZANTE)
──────────────────────────────────
Cria uma barra que você arrasta para escolher um valor.

SINTAXE:
KaisenUI:AddSlider("NOME", MIN, MAX, PADRÃO, section, function(valor)
    -- Código quando o valor muda
end)

EXEMPLO:
KaisenUI:AddSlider("Velocidade", 0, 100, 16, section, function(valor)
    -- Muda a velocidade do jogador
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = valor
end)

6.4 - TEXT INPUT (CAMPO DE TEXTO)
─────────────────────────────────
Cria um campo onde você pode digitar.

SINTAXE:
KaisenUI:AddTextInput("NOME", "PLACEHOLDER", section, function(texto)
    -- Código quando digitar
end)

EXEMPLO:
KaisenUI:AddTextInput("Nome", "Digite seu nome", section, function(texto)
    print("Você digitou: " .. texto)
end)

6.5 - DROPDOWN (MENU DE OPÇÕES)
───────────────────────────────
Cria um menu com várias opções para escolher.

SINTAXE:
KaisenUI:AddDropdown("NOME", {"OP1", "OP2", "OP3"}, "PADRÃO", section, function(escolhido)
    -- Código quando escolher uma opção
end)

EXEMPLO:
KaisenUI:AddDropdown("Modo", {"Fácil", "Médio", "Difícil"}, "Médio", section, function(escolhido)
    print("Você escolheu: " .. escolhido)
end)

═══════════════════════════════════════════════════════════
7️⃣ COMANDOS PARA CONTROLAR A UI
───────────────────────────────────────────────────────────

Mostrar a UI:
KaisenUI:Show()

Esconder a UI:
KaisenUI:Hide()

Alternar (mostrar/esconder):
KaisenUI:Toggle()

Destruir a UI (remover completamente):
KaisenUI:Destroy()

═══════════════════════════════════════════════════════════
8️⃣ EXEMPLO COMPLETO - PASSO A PASSO
───────────────────────────────────────────────────────────

VAMOS CRIAR UM SCRIPT DE AUTO FARM:

PASSO 1 - CARREGAR A UI:
───────────────────────
local KaisenUI = loadstring(game:HttpGet("URL"))({
    Title = "Script Farm",
    ToggleKey = Enum.KeyCode.G,
    MainColor = Color3.fromRGB(0, 255, 0)  -- VERDE
})

PASSO 2 - CRIAR SEÇÃO PRINCIPAL:
────────────────────────────────
KaisenUI:AddSection("Farm", "💰", function(section)
    
    -- Toggle para ligar/desligar o farm
    KaisenUI:AddToggle("Auto Farm", section, function(ativado)
        if ativado then
            print("Farm LIGADO!")
            -- Coloque aqui o código para começar a farmar
        else
            print("Farm DESLIGADO!")
            -- Coloque aqui o código para parar de farmar
        end
    end)
    
    -- Slider para escolher a velocidade
    KaisenUI:AddSlider("Velocidade", 0, 100, 50, section, function(valor)
        print("Velocidade: " .. valor)
        -- Coloque aqui o código para mudar a velocidade
    end)
    
    -- Botão para coletar tudo
    KaisenUI:AddButton("Coletar Tudo", section, function()
        print("Coletando tudo...")
        -- Coloque aqui o código para coletar
    end)
end)

PASSO 3 - CRIAR SEÇÃO DE CONFIGURAÇÕES:
──────────────────────────────────────
KaisenUI:AddSection("Config", "⚙️", function(section)
    
    -- Toggle para notificações
    KaisenUI:AddToggle("Notificações", section, function(ativado)
        print("Notificações: " .. tostring(ativado))
    end)
    
    -- Dropdown para escolher o modo
    KaisenUI:AddDropdown("Modo", {"Rápido", "Normal", "Lento"}, "Normal", section, function(escolhido)
        print("Modo escolhido: " .. escolhido)
    end)
end)

PASSO 4 - MOSTRAR A UI:
───────────────────────
KaisenUI:Show()

═══════════════════════════════════════════════════════════
9️⃣ EXEMPLOS RÁPIDOS
───────────────────────────────────────────────────────────

EXEMPLO 1 - SCRIPT DE TELEPORTE:
────────────────────────────────
local KaisenUI = loadstring(game:HttpGet("URL"))({
    Title = "Teleport Hub"
})

KaisenUI:AddSection("Teleport", "📍", function(section)
    KaisenUI:AddButton("Ir para Base", section, function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 10, 0)
    end)
    
    KaisenUI:AddButton("Ir para Farm", section, function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(100, 10, 0)
    end)
end)

EXEMPLO 2 - SCRIPT DE VELOCIDADE:
─────────────────────────────────
local KaisenUI = loadstring(game:HttpGet("URL"))({
    Title = "Speed Control"
})

KaisenUI:AddSection("Velocidade", "🏃", function(section)
    KaisenUI:AddSlider("WalkSpeed", 0, 100, 16, section, function(valor)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = valor
    end)
    
    KaisenUI:AddSlider("JumpPower", 0, 200, 50, section, function(valor)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = valor
    end)
end)

EXEMPLO 3 - SCRIPT DE COMANDOS:
───────────────────────────────
local KaisenUI = loadstring(game:HttpGet("URL"))({
    Title = "Comandos"
})

KaisenUI:AddSection("Comandos", "⌨️", function(section)
    KaisenUI:AddTextInput("Comando", "Digite um comando", section, function(texto)
        print("Comando: " .. texto)
        -- Execute o comando aqui
        loadstring(texto)()
    end)
end)

═══════════════════════════════════════════════════════════
🔟 DICAS IMPORTANTES
───────────────────────────────────────────────────────────

1️⃣ SEMPRE use a seção correta
   Os elementos só funcionam se você colocar dentro de uma seção.

2️⃣ O ToggleKey é a tecla para abrir/fechar
   Você pode mudar para qualquer tecla que quiser.

3️⃣ Guarde o link do script em um lugar seguro
   Você vai precisar dele para carregar a UI.

4️⃣ Você pode ter várias seções
   Quantas você quiser! É só ir adicionando.

5️⃣ Personalize as cores
   Deixe do seu jeito favorito.

═══════════════════════════════════════════════════════════
1️⃣1️⃣ ERROS COMUNS E SOLUÇÕES
───────────────────────────────────────────────────────────

❌ "A UI não aparece"
✅ Você chamou o KaisenUI:Show()?

❌ "A tecla não funciona"
✅ Verifique se você colocou a tecla certa

❌ "Os elementos não aparecem"
✅ Você colocou os elementos dentro de uma seção?

❌ "Erro no script"
✅ Verifique se você copiou tudo certinho

═══════════════════════════════════════════════════════════
1️⃣2️⃣ RESUMO EM POUCAS PALAVRAS
───────────────────────────────────────────────────────────

1. Carregue a UI com loadstring
2. Crie seções com AddSection
3. Adicione elementos (Toggle, Button, Slider, etc)
4. Mostre a UI com Show()
5. Use a tecla configurada para abrir/fechar

═══════════════════════════════════════════════════════════

🔧 MANUAL CRIADO POR KAISEN
📅 VERSÃO 2.0

QUALQUER DÚVIDA, CONSULTE O MANUAL COMPLETO!

═══════════════════════════════════════════════════════════
