import os
import json
from main_pipeline_pdfs import process_pdfs_directory


def main():
    """Run the PDF processing pipeline inside the container.

    All PDF files mounted to /app/input will be processed and the
    corresponding JSON files will be written to /app/output.
    An aggregated output.json will also be created.
    """
    input_dir = "/app/input"
    output_dir = "/app/output"

    # Make sure the output directory exists (it will be created even if not mounted yet)
    os.makedirs(output_dir, exist_ok=True)

    print(f"[INFO] Processing PDFs from {input_dir} → {output_dir}")

    results = process_pdfs_directory(input_dir, output_dir)

    # Previously we wrote an aggregated output.json here, but this is no longer
    # required. If you ever need an aggregate file again, uncomment the block
    # below or set an environment variable and write it conditionally.


if __name__ == "__main__":
    main() 