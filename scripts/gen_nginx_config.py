import sys
import os


def modify_text(new_text, server_ip):
    file_path = "nginx.txt"
    try:
        with open(file_path, "r") as file:
            data = file.read()

        # Replace old_text with new_text
        modified_data = data.replace("_tenant_name_", new_text).replace("_ip_", server_ip)

        # Write modified data back to the file
        with open(new_text, "w") as file:
            file.write(modified_data)

        print("Text modified successfully.")
    except FileNotFoundError:
        print("File not found.")
    except Exception as e:
        print(f"An error occurred: {str(e)}")


if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: python script.py <new_text> <server_ip>")
        sys.exit(1)

    new_text = sys.argv[1]
    server_ip = sys.argv[2]

    modify_text(new_text)
