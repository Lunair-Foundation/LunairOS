# LunairOS

### Português • [English](README.en.md)

LunairOS é uma distribuição Linux independente focada em trazer o esqueumorfismo de forma moderna, mantendo estabilidade e incorporando parte da filosofia BSD.

## Atual lançamento

**LunairOS 0.1.1 "Turmoil"**

## Status

Atualmente, o sistema:
- Compila um kernel Linux customizado
- Constrói uma initramfs baseada em BusyBox
- Inclui um pequeno userland próprio
- Gera uma imagem ISO bootável com GRUB
- Pode ser testado no QEMU

## Dependências

### Ferramentas necessárias para construir a ISO

- GRUB
- xorriso
- mtools
- cpio
- gzip
- file

### Ferramentas necessárias para compilar o kernel

- gcc ou clang
- make
- bc
- bison
- flex
- OpenSSL
- libelf
- dwarves

### Dependências adicionais

- BusyBox estático
- musl-tools
- wget
- tar
- xz

## Instalar dependências (Debian/Ubuntu)

```sh
make install-deps-debian
```

## Compilar o sistema

### Compilar apenas o userland

```sh
make builduserland
```

### Construir a initramfs

```sh
make buildworld
```

### Construir a release completa

```sh
make release
```

Isso irá:
- Verificar dependências
- Compilar o kernel
- Construir o userland
- Gerar a initramfs
- Criar a ISO bootável

## Executar no QEMU

```sh
make run
```

## Limpeza

### Limpar arquivos intermediários

```sh
make clean
```

### Remover toda a pasta de build

```sh
make distclean
```

## Estrutura do projeto

```text
kernel/        - Build e configuração do kernel Linux
initramfs/     - Estrutura da initramfs
userland/      - Programas do userland
iso/           - Geração da ISO e configuração do GRUB
build/         - Arquivos gerados durante a build
```

## Licença

LunairOS é licenciado sob a GNU General Public License v3.0 (GPLv3).

## Software de terceiros

LunairOS utiliza:

- Kernel Linux (GPLv2)
- BusyBox (GPLv2)
- GRUB
