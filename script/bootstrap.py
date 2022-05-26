import argparse
import sys
from pathlib import Path
import subprocess
from enum import Enum
import os


def ensure_permissions():
    if os.name == "nt":
        import ctypes
        if ctypes.windll.shell32.IsUserAnAdmin():
            return
        ctypes.windll.shell32.ShellExecuteW(None, "runas", sys.executable, " ".join(sys.argv), None, 1)
        sys.exit(0)


def ensure_symlinks(root: Path):
    if os.name == "nt":
        p = subprocess.run("git config --get core.symlinks", cwd=root, capture_output=True)
        if p.stdout.decode().strip() != "true":
            error = """
            Repository is cloned without symlinks properly set.
            Consider cloning it with the following command:
                git clone -c core.symlinks=true path/to/repository
            Or execute the following commands:
                git config --set core.symlinks true
                git reset --hard
            """
            raise RuntimeError(error)


class Action(Enum):
    SKIP = 1
    BACKUP = 2
    OVERWRITE = 3


def info(text):
    print(f"  [ \033[00;34m..\033[0m ] {text}")


def user(text):
    print(f"  [ \033[0;33m??\033[0m ] {text}")


def success(text):
    print(f"\033[2K  [ \033[00;32mOK\033[0m ] {text}")


def fail(text):
    print(f"\r\033[2K  [\033[0;31mFAIL\033[0m] {text}\n")
    sys.exit(1)
  

def init_submodules(root: Path):
    subprocess.run("git submodule update --init --recursive".split(), cwd=root)


def setup_gitconfig(root: Path):
    pass
    # TODO


def link_file(src: Path, dst: Path, action: Action):
    if dst.exists():
        print(dst, "exists")
        # TODO: Handle it
        return
    dst.symlink_to(src, src.is_dir())
    success(f"linked {src} to {dst}")
    

def install_dotfiles(root: Path, action: Action):
    info("installing dotfiles")
    for src in root.glob("**/*.symlink"):
        rel_parts = src.relative_to(root).parts
        if ".git" in rel_parts:
            # We're in Git internals
            continue
        if len(rel_parts) > 3:
            # Went too deep
            continue
        if os.name == "nt":
            if src.is_file() and not src.is_symlink():  # Not sure if I need to check both
                r = subprocess.run(f"git ls-files -s {src.absolute()}", cwd=root, capture_output=True)
                out = r.stdout.decode()
                if out.startswith("120000 "):
                    raise IOError(f"Unix symlink on Windows: {src}")
        dst = Path(Path.home(), "." + src.name.rstrip(".symlink"))
        link_file(src.absolute(), dst.absolute(), action)


def install_config_files(root: Path, action: Action):
    info("installing .config files")
    config_path = Path(Path.home(), ".config")
    if not config_path.exists():
        config_path.mkdir()
    for src in Path(root, "config").iterdir():
        dst = Path(config_path, src.name)
        link_file(src.absolute(), dst.absolute(), action)


def install_windows_links(root: Path, action: Action):
    with open(Path(root, "windows.links")) as f:
        for line in f:
            src, dst = line.strip().split(";", 1)
            src = Path(root, src)
            dst = Path(os.path.expandvars(dst))
            if src.exists():
                if not (prn := dst.absolute().parent).exists():
                    prn.mkdir()
                link_file(src.absolute(), dst.absolute(), action)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--nogit", dest="git", action="store_false", help="Do not create ~/.gitconfig")
    parser.add_argument("--skip", dest="action", action="store_const", const=Action.SKIP, help="Skip linking if file already exists")
    parser.add_argument("--overwrite", dest="action", action="store_const", const=Action.OVERWRITE, help="Overwrite existing files")
    parser.add_argument("--backup", dest="action", action="store_const", const=Action.BACKUP, help="Rename existing files")
    ns = parser.parse_args()
    # Assuming the setup.py script is located in the $dotfiles/script
    dotfiles_root = Path(sys.argv[0]).parent.parent

    ensure_permissions()
    ensure_symlinks(dotfiles_root)
    init_submodules(dotfiles_root)
    if ns.git:
        setup_gitconfig(dotfiles_root)
    install_dotfiles(root=dotfiles_root, action=ns.action)
    install_config_files(root=dotfiles_root, action=ns.action)
    if os.name == "nt":
        install_windows_links(root=dotfiles_root, action=ns.action)


if __name__ == "__main__":
    main()
