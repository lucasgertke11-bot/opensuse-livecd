# openSUSE Base - mkosi Configuration

Arquivos de configuração do **mkosi** para criar base mínima do openSUSE.

## Arquivos

| Arquivo | Descrição |
|---------|-----------|
| `mkosi.conf` | Configuração padrão (Leap 15.6) |
| `mkosi-leap.conf` | Leap 15.6 com kernel e bootloader |
| `mkosi-tumbleweed.conf` | Tumbleweed rolling |
| `build-base.sh` | Script para executar o build |

## Como usar

### 1. Instalar dependências (no host)

```bash
# Ubuntu/Debian
sudo apt install mkosi

# Fedora
sudo dnf install mkosi

# Arch Linux
sudo pacman -S mkosi

# openSUSE
sudo zypper install mkosi
```

### 2. Gerar a base

```bash
# Para Leap
cp mkosi-leap.conf mkosi.conf
sudo mkosi

# Para Tumbleweed
cp mkosi-tumbleweed.conf mkosi.conf
sudo mkosi
```

A base será criada em `./output/`

### 3. No DistroForge Studio

Após gerar a base:

```bash
# Entrar no chroot
sudo chroot ./output

# Instalar Calamares
zypper in calamares

# Instalar interface (escolha uma)
zypper in patterns-kde-kde_kde     # KDE Plasma
zypper in patterns-gnome-gnome     # GNOME
zypper in patterns-xfce-xfce      # XFCE
zypper in patterns-gnome-gnome_x11 # GNOME com X11

# Sair do chroot
exit

# Gerar ISO
mkisofs -r -o minha-distro.iso -b isolinux.bin -no-emul-boot -boot-load-size 4 -boot-info-table ./output
```

## Para Hospedar no GitHub

Após executar o mkosi, a pasta `./output` contém o sistema base. Você pode:

1. Criar um repositório Git LFS para armazenar
2. Ou compactar e fazer release no GitHub:
```bash
tar -cvzf opensuse-base.tar.gz output/
# Fazer upload como release no GitHub
```

## Requisitos do Host

- Linux (qualquer distribuição)
- mkosi instalado
- zypper (para gerenciar pacotes openSUSE)
- systemd (para o mkosi usar como container)
