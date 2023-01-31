{% from 'lib.sls' import k8s_distro %}

base:
  '*':
    {% if k8s_distro == 'k3s' %}
    - k3s
    {% elif k8s_distro == 'rke2' %}
    - rke2
    {% endif %}
