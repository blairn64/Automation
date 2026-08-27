"""Run the synthetic enterprise dataset generators."""

from __future__ import annotations

import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).parent
SCRIPTS = ["generate-users.py", "generate-signins.py", "generate-tickets.py"]


def main() -> None:
    for script in SCRIPTS:
        completed = subprocess.run([sys.executable, str(ROOT / script)], check=False)
        if completed.returncode:
            raise SystemExit(completed.returncode)

    print("Enterprise lab synthetic datasets generated successfully.")


if __name__ == "__main__":
    main()
