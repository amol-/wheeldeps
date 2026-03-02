#!/usr/bin/env python3
"""Assert that consolidated wheels include one copy of each expected native library."""

from __future__ import annotations

import argparse
import collections
import pathlib
import sys
import zipfile


def demangle_lib_name(filename: str) -> str:
    stem, suffix = pathlib.Path(filename).stem, pathlib.Path(filename).suffix
    return f"{stem.rsplit('-', 1)[0]}{suffix}"


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Verify expected shared libraries appear exactly once across wheels."
    )
    parser.add_argument(
        "wheels_dir",
        help="Directory containing consolidated wheel files.",
    )
    parser.add_argument(
        "expected_libs",
        nargs="+",
        help="Expected demangled library file names (for example libfoo.so foo.dll).",
    )
    return parser.parse_args()


def main() -> int:
    opts = parse_args()
    wheels = sorted(pathlib.Path(opts.wheels_dir).glob("*.whl"))
    if not wheels:
        print(f"No wheel files found in {opts.wheels_dir}")
        return 1

    expected = set(opts.expected_libs)
    counts: collections.Counter[str] = collections.Counter()
    seen_locations: dict[str, list[str]] = collections.defaultdict(list)
    extensions = (".dll", ".so", ".dylib")

    for wheel in wheels:
        with zipfile.ZipFile(wheel) as archive:
            for filename in archive.namelist():
                if not filename.lower().endswith(extensions):
                    continue
                demangled = demangle_lib_name(pathlib.Path(filename).name)
                if demangled not in expected:
                    continue
                counts[demangled] += 1
                seen_locations[demangled].append(f"{wheel.name}:{filename}")

    failures = []
    for libname in sorted(expected):
        found = counts[libname]
        locations = ", ".join(seen_locations.get(libname, []))
        print(f"{libname}: {found} [{locations}]")
        if found != 1:
            failures.append(libname)

    if failures:
        print(
            "Expected each target library to appear exactly once across consolidated wheels."
        )
        print("Mismatched libraries:", ", ".join(failures))
        return 1

    print("All expected libraries were found exactly once.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
