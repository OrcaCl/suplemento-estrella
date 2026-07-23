#!/usr/bin/env python3
"""
Rename a project cloned from Suplemento Estrella.

Renames:

Title  -> README / docs
Slug   -> repository names
Module -> package / code identifiers

Example:

python scripts/rename_project.py \
    --old-title "Suplemento Estrella" \
    --new-title "Suplemento Estrella" \
    --old-slug "suplemento-estrella" \
    --new-slug "suplemento-estrella" \
    --old-module "Suplemento Estrella" \
    --new-module "suplemento" \
    --dry-run
"""

from __future__ import annotations

import argparse
import pathlib
import re
import shutil

IGNORE_DIRS = {
    ".git",
    ".venv",
    "node_modules",
    "__pycache__",
    "dist",
    "build",
    ".mypy_cache",
    ".pytest_cache",
}


TEXT_EXTENSIONS = {
    ".md",
    ".txt",
    ".py",
    ".json",
    ".toml",
    ".yaml",
    ".yml",
    ".ini",
    ".cfg",
    ".js",
    ".ts",
    ".tsx",
    ".jsx",
    ".css",
    ".scss",
    ".html",
    ".jinja",
    ".sql",
    ".sh",
    ".env.example",
}


def should_skip(path: pathlib.Path) -> bool:
    return any(part in IGNORE_DIRS for part in path.parts)


def replace_content(path: pathlib.Path, args, dry_run: bool) -> bool:

    if path.suffix not in TEXT_EXTENSIONS and path.name != ".gitignore":
        return False

    try:
        text = path.read_text(encoding="utf-8")
    except Exception:
        return False

    original = text

    text = re.sub(
        re.escape(args.old_slug),
        args.new_slug,
        text,
        flags=re.IGNORECASE,
    )

    text = re.sub(
        re.escape(args.old_title),
        args.new_title,
        text,
        flags=re.IGNORECASE,
    )

    text = re.sub(
        rf"\b{re.escape(args.old_module)}\b",
        args.new_module,
        text,
        flags=re.IGNORECASE,
    )

    if text == original:
        return False

    print(f"📝 {path}")

    if not dry_run:
        path.write_text(text, encoding="utf-8")

    return True


def rename_paths(root: pathlib.Path, old: str, new: str, dry_run: bool):

    paths = sorted(root.rglob("*"), reverse=True)

    for path in paths:

        if should_skip(path):
            continue

        if old.lower() not in path.name.lower():
            continue

        new_name = re.sub(
            re.escape(old),
            new,
            path.name,
            flags=re.IGNORECASE,
        )

        target = path.with_name(new_name)

        print(f"📂 {path} -> {target}")

        if not dry_run:
            shutil.move(path, target)


def main():

    parser = argparse.ArgumentParser()

    parser.add_argument("--old-title", required=True)
    parser.add_argument("--new-title", required=True)

    parser.add_argument("--old-slug", required=True)
    parser.add_argument("--new-slug", required=True)

    parser.add_argument("--old-module", required=True)
    parser.add_argument("--new-module", required=True)

    parser.add_argument(
        "--dry-run",
        action="store_true",
    )

    args = parser.parse_args()

    root = pathlib.Path(__file__).resolve().parent.parent

    if not (root / ".git").exists():
        raise SystemExit(
            f"❌ No se encontró un repositorio Git en:\n{root}"
        )
    print(f"📁 Proyecto: {root}")

    print()
    print("======================================")
    print("      Rename Project Utility")
    print("======================================")
    print()

    count = 0

    for path in root.rglob("*"):

        if should_skip(path):
            continue

        if path.is_file():
            if replace_content(path, args, args.dry_run):
                count += 1

    rename_paths(
        root,
        args.old_slug,
        args.new_slug,
        args.dry_run,
    )

    rename_paths(
        root,
        args.old_module,
        args.new_module,
        args.dry_run,
    )

    print()
    print("--------------------------------------")
    print(f"✔ Files modified: {count}")
    print("--------------------------------------")

    if args.dry_run:
        print()
        print("Dry run completed. No files were changed.")


if __name__ == "__main__":
    main()
