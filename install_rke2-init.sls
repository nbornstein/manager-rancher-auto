rke2_setup1:
  cmd.run:
    - name: "curl -sfL https://get.rke2.io | sh -"

rke2_setup2:
  cmd.run:
    - name: "while [ ! -f /tmp/rke2-ready ]; do kubectl get nodes | grep Ready; if [ $? -eq 0 ]; then touch /tmp/rke2-ready; fi; done"

rke2_setup3:
  cmd.run: 
    - name: "systemctl enable --now rke2-server.service"
    - onlyif:
      - test -f /tmp/rke2-ready