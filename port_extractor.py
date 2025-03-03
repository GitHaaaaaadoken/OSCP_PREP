import re
import sys

def extract_ports(nmap_output_file):
    try:
        with open(nmap_output_file, 'r') as file:
            data = file.readlines()
    except FileNotFoundError:
        print(f"Error: File '{nmap_output_file}' not found.")
        sys.exit(1)
    
    port_pattern = re.compile(r'^(\d+)/')  # Matches port numbers at the beginning of a line
    ports = set()
    
    for line in data:
        match = port_pattern.match(line)
        if match:
            ports.add(match.group(1))
    
    if not ports:
        print("No ports found in the Nmap output.")
        sys.exit(1)
    
    sorted_ports = sorted(map(int, ports))  # Sort numerically
    formatted_ports = ','.join(map(str, sorted_ports))
    
    print(f"Extracted Ports: {formatted_ports}")
    print(f"Use this in Nmap: nmap -p {formatted_ports} <target>")
    
    return formatted_ports

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python extract_ports.py <nmap_output_file>")
        sys.exit(1)
    
    extract_ports(sys.argv[1])

