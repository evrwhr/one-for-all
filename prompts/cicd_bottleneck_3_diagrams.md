Crie diagramas de arquitetura claros, em inglês nos rótulos dos boxes (padrão técnico), com setas direcionais e legendas curtas. Use cores distintas para: repositórios, workflows/actions, fluxos de dados/checkout, e “problemas/riscos”.

Estilo: diagrama de arquitetura corporativo, estilo “Big Tech slide deck” / “AWS architecture diagram”, sem ícones fofos, sem emojis nos boxes, sem decoração.

Formas: retângulos com cantos levemente arredondados ou retos; tamanhos consistentes; alinhamento em grade; muito espaço em branco.

Tipografia: uma só família; hierarquia por tamanho e peso, não por cor neon; títulos curtos; no máximo 2 linhas por box.

Cores: paleta restrita (3–5 cores + cinzas); fundo branco ou cinza muito claro; acentos só para tipo de componente (ex.: compute, dados, CI, externo).

Setas: finas, uma espessura, orthogonal ou curvas suaves discretas; rótulos pequenos nas arestas quando necessário.
Legendas: caixa única “Legend” com significado das cores, não espalhar explicação pelo desenho.

Ícones: se usar, só ícones genéricos minimalistas (servidor, banco, repositório) ou nenhum ícone — prefira texto.

Fonte
Excalidraw: a font padrão já é “hand-drawn”; para parecer mais profissional, peça explicitamente: “use Excalidraw font: Normal (sans), not hand-drawn” ou “disable sketch/hand-drawn look” se o connector expuser essa opção.

Se não der para trocar fonte via connector: peça ALL CAPS só em títulos de seção (moderado), Title Case nos componentes, e evitar texto longo — isso ajuda mesmo com fonte casual.
(Nomes exatos de opção variam conforme a integração Claude ↔ Excalidraw; o importante é pedir sans, reto, sem rugosidade.)

Paleta de cores
Use cinzas para 70% do diagrama e cor só para categorias:

Uso	Hex aproximado	Notas
Fundo	#FFFFFF ou #F7F8FA	Neutro
Borda / texto	#111827 / #6B7280	Contraste legível
Apps / runtime	#1D4ED8 (azul sóbrio)	Um tom só
CI/CD / automação	#7C3AED (roxo contido) ou #0F766E (teal)	Escolha uma cor de “pipeline”
Dados / secrets	#B45309 (âmbar escuro)	Só se fizer sentido
Alerta / legado / risco	#B91C1C
Regra: não misturar verde-limão, rosa, laranja forte e azul elétrico no mesmo frame.

Grid mental: alinhar todos os boxes à mesma largura dentro de cada camada (ex.: camada “Repos” em cima, “Runners/GHA” no meio, “Cluster” embaixo).

Grouping: cada frame com um container (subtítulo + conteúdo), não caixas soltas.

Nomenclatura: padrão fixo — repo/workflow.yml ou action/name@vX, sem misturar com frases longas.

Densidade: menos setas; preferir um fluxo principal e notas “side” em texto pequeno.

Consistência: mesma cor = mesmo tipo de coisa em todos os frames (não trocar azul de “app” no frame 2).

Evitar: sombras pesadas, gradientes, stickers, “callouts” gigantes, mais de 2 font sizes por frame.


CONTEXTO (análise CI/CD turnoverbnb-web):

1) ARQUITETURA ATUAL — Docker build (produção)
- Multi-stage Dockerfile com estes estágios e relações:
  - Stage `go` (golang:1.21-alpine): código morto — nunca copiado para production.
  - Stage `composer` (composer:2.6) → alimenta `builder` (PHP 8.3 Alpine).
  - `builder` → `node` (ubuntu:22.04 + NVM + Node 15 EOL) e também → `production`.
  - `node` → copia `public/` para `production`.
- Desenhe um primeiro frame/canvas: “Current: Docker multi-stage build”.

2) ARQUITETURA ATUAL — Pipeline CI/CD principal (devops/cicd.yml)
- Sequência: pr-info → update-branch (sleep 120) → em paralelo conceitual: run-tests (Unit+Feature sequencial no mesmo job) e deploy-staging → regression-tests (Playwright) → ambos convergem em wait-checks (polling sleep 30) → merge-pr.
- Segundo frame: “Current: GitHub Actions merge pipeline (cicd.yml)”.

3) ARQUITETURA ATUAL — Ecossistema de repos e workflows (mapa macro)
- turnoverbnb-web (.github): vários workflows (turno-web-cicd, pr-tests, ci, legacy-pest, push-image, prd-image, deploys, etc.); composite action setup-laravel-tests NÃO usada.
- devops: cicd.yml, turno_web_cicd.yml, create_turno_web_release.yml; composite setup-turno-web-laravel-tests NÃO usada.
- github-actions: build-and-push, echo-message, update-readme — hoje só taskuro-api usa build-and-push.
- gitops: reusable-docker-build, on-demand-cleanup — checkout dinâmico / gh pr list para turnoverbnb-web.
- helm-charts: release, pull-request.
- Problemas a anotar em callouts: 3 fontes de Docker build; 3 pipelines de merge concorrentes; 3 pipelines de teste em PR; actions não usadas; gitops reusable-docker-build não consumido pelo web.
- Terceiro frame: “Current: Multi-repo CI/CD landscape”.

4) SOLUÇÕES PROPOSTAS — desenhe CADA uma em frame separado:

**Opção A — Hub centralizado (github-actions)**
- Hub: composite actions (build-and-push, setup-laravel, setup-playwright) + reusable workflows (test-php, docker-build, merge-pipeline, regression).
- turnoverbnb-web: on-pr.yml, on-push-master.yml, on-tag.yml → chamam os reusables.
- devops: scheduled-merge.yml → reusable-merge-pipeline.
- Mostrar encadeamento: app → reusable → composite.

**Opção B — Workflows nos repos + apenas actions compartilhadas**
- github-actions: só actions (build-and-push, setup-laravel, setup-playwright, cache-composer).
- turnoverbnb-web: pr-tests, push-image, prd-image usando steps `uses`.
- devops: cicd + create-release usando as mesmas actions.
- Nota visual: menos centralização de orquestração.

**Opção C — Orquestração no devops + library no github-actions**
- devops: único cicd de merge, create-release, regression — checkout turnoverbnb-web + uses actions.
- turnoverbnb-web: só pr-checks leves + push-image.
- Destacar: um pipeline de merge, devops como hub operacional.

5) TARGET STATE (recomendação do doc — alinhado à Opção A)
- github-actions: 4 composites + 3 reusables (test-php, docker-build consolidado com gitops, regression-playwright).
- turnoverbnb-web: 3 workflows finos (PR lint+unit, push master build, tag prd+sentry).
- devops: cicd (merge único) + create-release — todos consomem reusables.
- gitops: on-demand; migrar/deprecar reusable-docker-build em favor do hub.
- Quarto/quinto frame: “Target: Centralized github-actions hub”.

6) Melhorias transversais (opcional, frame pequeno ou notas)
- Dockerfile: composer copy order, webpack filesystem cache + BuildKit mount, Node 18+, remover stage go, Sentry fora do build Docker, COPY seletivo no stage node.
- CI: cache Composer/Playwright, Unit||Feature paralelos, polling em vez de sleep 120, deploy-production com needs em todos os shards.

REQUISITOS DE ENTREGA:
- Comece pelo “Current” (Docker + cicd.yml + landscape).
- Depois Opções A, B, C e por fim Target.
- Inclua legenda de cores e uma caixa “Pain points” no frame atual.
- Se o Excalidraw permitir, agrupe por frames/slides para apresentação.