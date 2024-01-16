################################################################################
# Autor: Wellington Santos Souza
# Data: 16-01-2024
# Objetivo: Analisar os dados coletados do site SIDRA/IBGE utilizando o pacote SidraR
################################################################################

# Instalando e carregando os pacotes necessários
if(!require("sidrar")) install.packages("sidrar")
if(!require("tidyverse")) install.packages("tidyverse")

library(sidrar)
library(tidyverse)

# Tabela 6461 - Taxa de participação na força de trabalho, na semana de referência,
# das pessoas de 14 anos ou mais de idade

# Coletando os dados

dados_BR = get_sidra(
  x = "6461",
  variable = "4096",
  period = c('last' = 47),
  geo = "Brazil",
  header = TRUE
  )

# Tratamento dos dados

dados_BR_T = dados_BR %>%
  mutate(Valor = as.numeric(Valor)) %>% 
  mutate("Variável (Código)" = as.factor(`Trimestre (Código)`))

# Visualizando os dados
Tx_Part_Br = ggplot(dados_BR_T, aes(x = `Trimestre (Código)`, y = Valor)) +
  geom_line(aes(group = 1)) +
  geom_point(color = 'blue') +
  geom_text(aes(label = Valor), vjust = -0.5, hjust = 0.5, size = 3, color = 'red') +
  labs(title = "Taxa de participação na força de trabalho, na semana de referência, das pessoas de 14 anos ou mais de idade",
       subtitle = "Brasil 1° Trimestre de 2012 a 3° Trimestre de 202",
       x = "Trimestre/Ano",
       y = "Taxa de participação na força de trabalho (%)") +
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        axis.title.x = element_text(hjust = 0.5),
        axis.title.y = element_text(hjust = 0.5),
        axis.text.x = element_text(angle = 30, hjust = 1),
        axis.text.y = element_text(angle = 0, hjust = 1),
        legend.position = "none")
Tx_Part_Br


ggsave("Taxa_Participacao_Br.png", width = 20, height = 10, dpi = 400)  
  
  
  
  
  
  
  
  