"""Run the synthetic enterprise dataset generators and correlation."""

from __future__ import annotations

import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).parent
SCRIPTS = [
    "generate-users.py",
    "generate-signins.py",
    "generate-tickets.py",
    "join-identity-support.py",
]


def main() -> None:
    for script in SCRIPTS:
        completed = subprocess.run([sys.executable, str(ROOT / script)], check=False)
        if completed.returncode:
            raise SystemExit(completed.returncode)

    print("Enterprise lab synthetic datasets and operational correlation generated successfully.")


if __name__ == "__main__":
    main()
