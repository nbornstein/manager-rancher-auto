{% from 'lib.sls' import k8s_server %}
{% from 'lib.sls' import k8s_token %}
{% from 'lib.sls' import k8s_cni %}
{% from 'lib.sls' import k8s_datastore_endpoint %}

rke2:
  server: {{ k8s_server }}
  token: {{ k8s_token }} 
  cni: {{ k8s_cni }}
  datastore-endpoint: {{ k8s_datastore_endpoint }}
