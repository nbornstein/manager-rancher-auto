{% set k8s-distro = 'k3s' %}

{% set k8s-server = 'k3s-1.susedojo.com' %}
{% set k8s-token = 'K3sdemotokenwithSUMA' %}
{% set k8s-cni = '' %}
{% set k8s-datastore-endpoint = '' %}

base:
  '*':
    {% if k8s-distro == 'k3s' %}
    - k3s
    {% elif k8s-distro == 'rke2' %}
    - rke2
    {% endif %}
