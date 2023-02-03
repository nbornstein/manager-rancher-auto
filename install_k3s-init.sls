{% set k3s_token = salt['pillar.get']('k3s:token') %}

/usr/local/bin/register-rancher.sh:
  file.managed:
    - source: salt://manager_org_1/install_k3s-init/usr/local/bin/register-rancher.sh
    - name: "/usr/local/bin/register-rancher.sh"
    - user: root
    - group: root
    - mode: 744

k3s_setup1:
  cmd.run:
    - name: "curl -sfL 'https://get.k3s.io' | INSTALL_K3S_VERSION='v1.24.10+k3s1' sh -s - server --token {{ k3s_token }}"

k3s_setup2:
  cmd.run:
    - name: "while [ ! -f /tmp/K3s-Ready ]; do sleep 5; kubectl get nodes | grep -w 'Ready'; if [ $? -eq 0 ]; then touch /tmp/K3s-Ready; fi; done"

k3s_setup3:
  cmd.run: 
    - name: "/usr/local/bin/register-rancher.sh"
    - onlyif:
      - test -f /tmp/K3s-Ready