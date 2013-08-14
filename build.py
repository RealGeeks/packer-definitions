import subprocess

def get_output(command):
    p = subprocess.Popen(command, stdout=subprocess.PIPE)
    return p.communicate()[0]

def get_all_hosts(env="development"):
    roles = get_output(['server_config/rgenvs.py', '-roles'])

    hosts = set()

    for role in roles.split('\n'):
        host = get_output(['server_config/rgenvs.py', '-hosts', '-role={0}'.format(role), '-env={0}'.format(env)])
        if host:
            hosts.add(host.strip())

    return hosts

def replace_hostname(template, hostname):
    return template.replace('$PACKER_HOST', hostname)

def write_host_files(host):
    template = open('template/http/ks.cfg').read()
    with open('tmp/ks-{0}.cfg'.format(host),'w') as ks:
        ks.write(replace_hostname(template,host))

def main():
    for host in get_all_hosts():
        write_host_files(host)

if __name__ == '__main__':
    main()
