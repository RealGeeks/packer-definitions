import shutil
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
    print "copying {0}".format(host)
    shutil.copytree('template', 'tmp/{0}'.format(host))
    template = open('template/http/ks.cfg').read()
    with open('tmp/{0}/http/ks.cfg'.format(host),'w') as ks:
        ks.write(replace_hostname(template,host))


def main():
    shutil.rmtree('tmp')
    for host in get_all_hosts():
        write_host_files(host)


if __name__ == '__main__':
    main()
